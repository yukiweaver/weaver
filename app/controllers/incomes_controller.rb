class IncomesController < ApplicationController
  def new
    @income = Income.new
    @user = User.find(user_id)
  end

  def create
    @user = User.find(user_id)
    # income = params[:income]
    # date = Date.new(income["idate(1i)"].to_i, income["idate(2i)"].to_i, income["idate(3i)"].to_i)
    # 外部キーとしてuser_idをinsertする必要があるため、紐付け必須。
    @income = @user.incomes.build(income_params)
    if @income.save
      flash[:success] = "保存しました。"
    else
      flash[:danger] = "保存に失敗しました。"
    end
    redirect_to new_income_path
  end




  private
    # 収入ストパラ
    def income_params
      params.require(:income).permit(:imoney, :icategory, :inote, :idate)
    end
end
