class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_one :address
  has_many :invoices

  accepts_nested_attributes_for :address, allow_destroy: true, reject_if: :all_blank

  validates_associated :address
  validates_presence_of :address
  validates :icp, presence: true, uniqueness: true, length: { minimum: 9, maximum: 9 }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # before_save { email&.downcase! }

  has_secure_password

  def admin?
    email == 'admin@admin.admin'
  end
end
