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
        # session[:login_user] = {'_login' => {'user_id' => user.id, 'name' => user.name, 'email' => user.email}}
        redirect_to household_path(:user_id => user_id, :status => 'expense')
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
    session.delete(:user_id)
    @current_user = nil
    flash[:info] = 'ログアウトしました。'
    redirect_to root_path
  end
end
