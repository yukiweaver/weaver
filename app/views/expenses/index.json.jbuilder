json.array!(@expenses_data) do |expense|
  # json.extract! expense[0], :id, :enote, :ecategory_id
  json.title expense[0][:emoney]
  json.start expense[0][:edate]
  json.end expense[0][:edate]
  # json.url expense_url(expense, format: :html)
end
