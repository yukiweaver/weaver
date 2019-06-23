class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.integer :icategory
      t.string :inote
      t.date :idate
      t.integer :imoney
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :incomes, [:user_id, :created_at]
  end
end
