class UsersController < ApplicationController
  def home
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'アカウント登録しました。'
    else
      render 'new'
    end
    # redirect_to new_user_path
  end

  private
    # 新規登録　ストパラ
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
