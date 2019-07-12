class Expense < ApplicationRecord
  belongs_to :user
  enum ecategory_id: { food: 0, eating_out: 1, daily_necessities: 2, traffic: 3, clothes: 4,
                       companionship: 5, hobby: 6, other: 7 }

  # validate :incorrect_imoney

  validates :emoney, presence: true
  validates :ecategory_id, presence: true
  validates :edate, presence: true
end
