class ExpensesController < ApplicationController
  include ExpensesHelper
  # 支出　保存処理
  def create
    @user = User.find(user_id)
    @expense = @user.expenses.build(expense_params)
    if @expense.color.blank? || @expense.highlight.blank?
      insert_color_highlight()
    end
    # binding.pry
    if @expense.save
      flash[:success] = "保存しました。"
    else
      flash[:danger] = "保存に失敗しました。"
    end
    redirect_to household_path(user_id: user_id, status: 'expense')
  end

  # 更新
  def update
    @user = User.find(user_id)
    @expense = @user.expenses.find(params[:expense][:id])
    if @expense.update_attributes(expense_params)
      flash[:success] = '更新しました。'
    else
      flash[:danger] = '編集に失敗しました。'
    end
    redirect_to expenses_path
    # binding.pry
  end

  # 削除
  def destroy
    @user = User.find(user_id)
    @expense = @user.expenses.find(params[:id])  
    if @expense.destroy
      flash[:success] = '削除しました。'
    else
      flash[:danger] = '削除に失敗しました。'
    end
    redirect_to expenses_path
  end

  # カレンダーページ
  def index
    @expenses = Expense.where(user_id: user_id).select(:id, :user_id, :edate, :emoney)
    # RelationからArrayに変換（多次元配列）
    @expenses_data = @expenses.map {|item| [item]}
    @expenses_data.each do |expense|
      total = 0
      # selectで条件に一致すれば配列を返す
      values = @expenses_data.select { |value| value[0][:edate] == expense[0][:edate] }
      # binding.pry
      if !values.blank?
        values.each { |i| total += i[0][:emoney]}
        expense[0][:emoney] = total.to_i
        # 条件に一致する要素を削除（破壊的）
        @expenses_data.delete_if { |item| item[0][:edate] == expense[0][:edate] }
        # 配列の先頭に要素を追加（破壊的）。末尾に追加するとeachが終わらないため、注意。
        @expenses_data.unshift(expense)
        # 要素をすべて削除し、配列を空にする（破壊的）
        values.clear
      end
    end

    if params[:current_day].nil?
      @current_day = Date.today
    else
      @current_day = Date.parse(params[:current_day])
    end
    @last_month = @current_day.prev_month  #@current_dayからひと月前
    @next_month = @current_day.next_month  #@current_dayからひと月先
    @first_day = @current_day.beginning_of_month  #月初
    @last_day = @current_day.end_of_month  #月末

    # 指定の月の日付とお金のみをユニークで配列で取得
    uniq_current_month_days = get_current_month_expenses().select(:edate, :emoney).order(edate: "DESC").pluck(:edate).uniq
    
    # 多次元配列で取得
    @expenses_table_data = []
    uniq_current_month_days.each do |ucmd|
      expenses = Expense.where(user_id: user_id, edate: ucmd)
      @expenses_table_data.push(expenses)
    end

    # 指定の月の収入と支出の合計取得
    @total_income_money = total_current_month_imoney()
    @total_expense_money = total_current_month_emoney()
  end

  # 支出グラフページ
  def graph
    if params[:current_day].nil?
      @current_day = Date.today
    else
      @current_day = Date.parse(params[:current_day])
    end
    @last_month = @current_day.prev_month  #@current_dayからひと月前
    @next_month = @current_day.next_month  #@current_dayからひと月先
    @first_day = @current_day.beginning_of_month  #月初
    @last_day = @current_day.end_of_month  #月末

    # RelationからArrayへ(多次元配列)
    # カテゴリーが同じものの金額を合計して配列へ
    arr_month_expenses = get_current_month_expenses().map {|expense| [expense]}
    arr_month_expenses.each do |ame|
      total = 0
      values = arr_month_expenses.select {|value| value[0][:ecategory_id] == ame[0][:ecategory_id]}
      # binding.pry
      if !values.blank?
        values.each {|i| total += i[0][:emoney]}
        ame[0][:emoney] = total.to_i
        arr_month_expenses.delete_if {|item| item[0][:ecategory_id] == ame[0][:ecategory_id]}
        arr_month_expenses.unshift(ame)
        values.clear
      end
    end
    # emoneyで降順並び替え (gonはjs用)
    @arr_month_expenses = gon.arr_month_expenses = arr_month_expenses.sort { |a, b| a[0][:emoney] <=> b[0][:emoney] }.reverse
    @total_expense_money = total_current_month_emoney()
  end

  def bar_graph
    data = {'5' => '80605', '6' => '78651', '7' => '157343'}
    #　特定の月の収入と支出の合計
    data2 = {
      '5' => {'income' => 200000, 'expense' => 150000},
      '6' => {'income' => 200000, 'expense' => 170000}
    }

    # 日付を配列でユニークで取得後、フォーマットを年月に文字列変換 -> そこからさらにユニークで配列取得
    array = []
    uniq_days = Expense.where(user_id: user_id).select(:edate).order(:edate).pluck(:edate).uniq
    uniq_days.each do |day|
      str_month = day.strftime("%Y/%m/")
      array.push(str_month)
    end
    uniq_months = array.uniq

    total_month_expenses = []
    uniq_months.each do |month|
      first_day = Date.parse("#{month}/01")
      last_day = first_day.end_of_month
      expenses = Expense.where(user_id: user_id).where("edate >= ? and edate <= ?", first_day, last_day).select(:edate, :emoney).order(:edate)
      total_month_expenses.push(expenses)
      # binding.pry
    end

    # 月ごとの支出額の合計を配列で取得  例：[20000, 40000, 55555] 左から月の昇順で並んでいる
    month_total_emoney = []
    total_month_expenses.each do |tme|
      total = 0
      tme.each do |t|
        total += t[:emoney]
      end
      month_total_emoney.push(total.to_i)
    end
    # binding.pry
  end


  private
    # 支出ストロングパラメーター
    def expense_params
      params.require(:expense).permit(:emoney, :ecategory_id, :enote, :edate, :color, :highlight)
    end

    # 指定の月の支出データを取得
    def get_current_month_expenses
      Expense.where(user_id: user_id).where("edate >= ? and edate <= ?", @first_day, @last_day)
    end

    # 指定の月の収入データを取得
    def get_current_month_incomes
      Income.where(user_id: user_id).where("idate >= ? and idate <= ?", @first_day, @last_day)
    end

    # 指定の月に使用した支出の総額を取得
    def total_current_month_emoney
      total_money = 0
      get_current_month_expenses().each do |expense|
        total_money += expense.emoney
      end
      return total_money
    end

    def total_current_month_imoney
      total_money = 0
      get_current_month_incomes().each do |income|
        total_money += income.imoney
      end
      return total_money
    end

    # 支出インサート時にcolor、highlightも一緒に登録するため、データ格納
    def insert_color_highlight
      category = @expense.ecategory_id
      @expense.color = COLOR_AND_HIGHLIGHT[category][:color]
      @expense.highlight = COLOR_AND_HIGHLIGHT[category][:highlight]
    end
end
