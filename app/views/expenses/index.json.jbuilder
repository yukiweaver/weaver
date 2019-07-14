json.array!(@expenses) do |expense|
  json.extract! expense, :id, :ecategory_id, :enote
  json.title expense.emoney
  json.start expense.edate
  json.end expense.edate
  json.url expense_url(expense, format: :html)
end