module IncomesHelper
  def is_income(params)
    if params == 'income'
      return true
    else
      return false
    end
  end

  def is_expense(params)
    if params == 'expense'
      return true
    else
      return false
    end
  end
end
