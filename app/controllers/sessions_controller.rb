class SessionsController < ApplicationController
  def new
    
  end

  # ログイン処理
  def create
    user = User.find_by(email: params[:email])
    if !user.blank?
      user_id = user.id
      if user.password == params[:password]
        session[:user_id] = user_id
        redirect_to income_path(user)
      else
        flash.now[:danger] = 'メールアドレス、またはパスワードが間違っています。'
        render 'new'
      end
    else
      flash.now[:danger] = 'メールアドレス、またはパスワードが間違っています。'
      render 'new'
    end
  end

  # ログアウト処理
  def destroy
    session[:user_id] = nil
    @current_user = nil
    flash[:info] = 'ログアウトしました。'
    redirect_to root_path
  end
end
