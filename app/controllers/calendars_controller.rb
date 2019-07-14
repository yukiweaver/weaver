class CalendarsController < ApplicationController
  def show
    @user = User.find(user_id)
    @expenses = Expense.all
  end
end
