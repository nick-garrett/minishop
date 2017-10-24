class Invoice < ApplicationRecord
  VALID_PRICE_REGEX = /\A\d+(?:\.\d{0,2})?\z/
  VALID_USAGE_REGEX = /\A\d+(?:\.\d{0,4})?\z/
  belongs_to :user

  validate :price_validation_before_cast, :usage_validation_before_cast
  validates :price, presence: true
  validates :usage, presence: true

  def price_validation_before_cast
    return unless price
    errors.add(:price, 'is invalid') unless price_before_type_cast.to_s.match?(VALID_PRICE_REGEX)
    errors.add(:price, 'must be greater than 0') unless price_before_type_cast.positive?
  end

  def usage_validation_before_cast
    return unless usage
    errors.add(:usage, 'is invalid') unless usage_before_type_cast.to_s.match?(VALID_USAGE_REGEX)
    errors.add(:usage, 'must be greater than 0') unless usage_before_type_cast.positive?
  end
end
