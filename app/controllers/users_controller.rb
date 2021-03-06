class UsersController < ApplicationController
  before_action :logout_check, only: [:new, :show]
  def use
  end

  def description
  end

  def new
    @user = User.new
  end

  # 新規登録　そのままログイン
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'アカウント登録しました。'
      redirect_to household_path(user_id: session[:user_id], status: 'expense')
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @income = Income.new
  end

  private
    # 新規登録　ストパラ
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
