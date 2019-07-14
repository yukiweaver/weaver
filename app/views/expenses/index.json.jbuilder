json.array!(@expenses) do |expense|
  json.extract! expense, :id, :enote, :ecategory_id
  json.title expense.emoney
  json.start expense.edate
  json.end expense.edate
  json.url expense_url(expense, format: :html)
end
