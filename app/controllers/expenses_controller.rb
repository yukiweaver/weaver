class ExpensesController < ApplicationController
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

  def index
    @expenses = Expense.all
    # respond_to do |format|
    #   format.any
    #   format.json {
    #     render json:
    #     @expenses.to_json(
    #       only: [:emoney, :edate, :enote]
    #     )
    #   }
    # end
  end


  private
    # 支出ストロングパラメーター
    def expense_params
      params.require(:expense).permit(:emoney, :ecategory_id, :enote, :edate)
    end
end
