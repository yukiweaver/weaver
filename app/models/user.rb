class User < ApplicationRecord
  has_many :incomes
  has_many :expenses
  before_save :email_downcase, unless: :uid?
  validates :name, presence: true, unless: :uid?, length: {in: 1..20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, unless: :uid?, uniqueness: true,
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, unless: :uid?, length: {in: 6..20}

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.image_url = image_url
    end
  end

  def email_downcase
    self.email.downcase!
  end
end
