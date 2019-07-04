class Income < ApplicationRecord
  belongs_to :user
  enum icategory: { salary: 0, other: 1 }

  validate :incorrect_imoney

  validates :imoney, presence: true
  validates :icategory, presence: true
  validates :idate, presence: true

  def incorrect_imoney
    if imoney <= 0
      errors.add(:imoney, "0より大きい金額を入力してください。")
    end
  end
end
