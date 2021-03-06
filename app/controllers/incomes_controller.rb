class IncomesController < ApplicationController
  include IncomesHelper
  before_action :login_check, only: [:new]
  def new
    @user = User.find(user_id)
    @params = params[:status]
    if @params == 'income'
      @income = Income.new
    elsif @params == 'expense'
      @expense = Expense.new
    else
      redirect_to error_path
    end
  end

  def create
    @user = User.find(user_id)
    income = params[:income]
    # date = Date.new(income["idate(1i)"].to_i, income["idate(2i)"].to_i, income["idate(3i)"].to_i)
    str_date = income["idate(1i)"] + "-" + income["idate(2i)"] + "-" + income["idate(3i)"]

    # 日付が不正か検証
    if date_valid?(str_date) === false
      flash[:danger] = "日付が不正です。"
      redirect_to household_path(user_id: user_id, status: 'income') and return
    end
    
    # 外部キーとしてuser_idをinsertする必要があるため、紐付け必須。
    @income = @user.incomes.build(income_params)
    if @income.save
      flash[:success] = "保存しました。"
    else
      flash[:danger] = "保存に失敗しました。"
    end
    redirect_to household_path(user_id: user_id, status: 'income')
  end




  private
    # 収入ストロングパラメーター
    def income_params
      params.require(:income).permit(:imoney, :icategory, :inote, :idate)
    end
end
