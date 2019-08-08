class User < ApplicationRecord
  has_many :incomes
  has_many :expenses
  validates :name, presence: true, length: {in: 1..20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {in: 6..20}
end
