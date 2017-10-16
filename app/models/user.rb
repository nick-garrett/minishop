class User < ApplicationRecord
  validate :address, presence: true, uniqueness: true
  validate :icp, presence: true, uniqueness: true
  validate :first_name, presence: true, length: { maximum: 50 }
  validate :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  before_save { email&.downcase! }

  # TODO: Validate address format, presence, length??? Should address be a model?(probably not)

  has_secure_password
end
