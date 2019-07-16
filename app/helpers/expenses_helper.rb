module ExpensesHelper
  def user_id
    @user_id = session[:user_id] ? session[:user_id] : nil
    return @user_id 
  end
end
