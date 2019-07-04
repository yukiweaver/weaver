class IncomesController < ApplicationController
  def new
    @income = Income.new
    @user = User.find(user_id)
  end

  def create
    @user = User.find(user_id)
  end




  private
    # 収入ストパラ
    def income_params
      params.require(:income).permit(:imoney, :icategory, :inote, :idate)
    end
end
