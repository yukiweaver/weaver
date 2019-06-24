class User < ApplicationRecord
  has_many :incomes
  has_many :expenses
  validates :name, presence: true, length: {in: 1..20}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {in: 6..20}
end
