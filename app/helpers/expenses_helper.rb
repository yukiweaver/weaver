module ExpensesHelper
  # 収入 - 支出
  def subtraction(income, expense)
    income - expense
  end

  CATEGORY_JA_CONVERT = {
    'food' => '食費',
    'eating_out' => '外食費',
    'daily_necessities' => '日用品',
    'traffic' => '交通費',
    'clothes' => '衣服',
    'companionship' => '交際費',
    'hobby' => '趣味',
    'other' => 'その他',
    'salary' => '給料'
  }
  
end
