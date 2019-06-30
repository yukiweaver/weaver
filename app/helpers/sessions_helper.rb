module SessionsHelper
  # ログイン中のユーザーを返す
  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find_by(id: session[:user_id])
    end
    return @current_user
  end
end
