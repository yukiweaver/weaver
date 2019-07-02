class Income < ApplicationRecord
  belongs_to :user
  enum icategory: { salary: 0, other: 1 }
end
