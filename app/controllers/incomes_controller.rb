class IncomesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @income = Income.new
  end
end
