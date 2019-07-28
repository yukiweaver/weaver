class AddColorToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :color, :string
    add_column :expenses, :highlight, :string
  end
end
