class ExpensesController < ApplicationController
  # 支出　保存処理
  def create
    @user = User.find(user_id)
    @expense = @user.expenses.build(expense_params)
    if @expense.save
      flash[:success] = "保存しました。"
    else
      flash[:danger] = "保存に失敗しました。"
    end
    redirect_to household_path(user_id: user_id, status: 'expense')
  end

  # 支出カレンダーページ
  def index
    @expenses = Expense.where(user_id: user_id).select(:id, :user_id, :edate, :emoney)
    # RelationからArrayに変換（多次元配列）
    @expenses_data = @expenses.map {|item| [item]}
    @expenses_data.each do |expense|
      total = 0
      # selectで条件に一致すれば配列を返す
      values = @expenses_data.select { |value| value[0][:edate] == expense[0][:edate] }
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

    if params['current_day'].nil?
      @current_day = Date.today
    else
      @current_day = Date.parse(params['current_day'])
    end
    @last_month = @current_day.prev_month  #@current_dayからひと月前
    @next_month = @current_day.next_month  #@current_dayからひと月先
    @first_day = @current_day.beginning_of_month  #月初
    @last_day = @current_day.end_of_month  #月末

    # 指定の月の日付のみを配列で取得
    current_month_expenses = Expense.where(user_id: user_id).where("edate >= ? and edate <= ?", @first_day, @last_day).select(:edate, :emoney).order(edate: "DESC")
    uniq_current_month_days = current_month_expenses.pluck(:edate).uniq
    # 多次元配列で取得
    @expenses_table_data = []
    uniq_current_month_days.each do |ucmd|
      expenses = Expense.where(user_id: user_id, edate: ucmd)
      @expenses_table_data.push(expenses)
    end

    # 指定の月の収入と支出の合計取得
    current_month_incomes = Income.where(user_id: user_id).where("idate >= ? and idate <= ?", @first_day, @last_day).select(:imoney)
    @total_income_money = 0
    @total_expense_money = 0
    current_month_incomes.each do |income|
      @total_income_money += income.imoney
    end
    current_month_expenses.each do |expense|
      @total_expense_money += expense.emoney
    end
  end


  private
    # 支出ストロングパラメーター
    def expense_params
      params.require(:expense).permit(:emoney, :ecategory_id, :enote, :edate)
    end
end
