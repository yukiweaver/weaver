class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :ecategory_id
      t.string :enote
      t.date :edate
      t.integer :emoney
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :expenses, [:user_id, :created_at]
  end
end
