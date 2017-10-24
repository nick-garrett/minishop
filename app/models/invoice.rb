class Invoice < ApplicationRecord
  belongs_to :user

  validates :price, presence: true
  validates :usage, presence: true
end
