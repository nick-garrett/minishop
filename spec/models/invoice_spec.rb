require 'rails_helper'

NO_PRICE_ERROR = "Price can't be blank".freeze
PRICE_FORMAT_ERROR = 'Price is invalid'.freeze
PRICE_RANGE_ERROR = 'Price must be greater than 0'.freeze
NO_USAGE_ERROR = "Usage can't be blank".freeze
USAGE_FORMAT_ERROR = 'Usage is invalid'.freeze
USAGE_RANGE_ERROR = 'Usage must be greater than 0'.freeze

RSpec.describe Invoice, type: :model do
  fixtures :users

  let(:user) { users(:user) }
  let(:invoice) { user.invoices.create(price: price, usage: usage) }
  let(:price) { 10.00 }
  let(:usage) { 5.4321 }

  describe '#price' do
    context 'when no price is given' do
      let(:price) { nil }

      it 'is not valid' do
        expect(invoice).not_to be_valid
      end

      it 'has the appropriate error' do
        expect(invoice.errors.full_messages).to include NO_PRICE_ERROR
      end
    end

    context 'when an invalid price is given' do
      let(:price) { 1.1110000001 }

      it 'is not valid' do
        expect(invoice).not_to be_valid
      end

      it 'has the appropriate error' do
        expect(invoice.errors.full_messages).to include PRICE_FORMAT_ERROR
      end
    end

    context 'when a price less than 0 is given' do
      let(:price) { -2 }

      it 'is not valid' do
        expect(invoice).not_to be_valid
      end

      it 'has the appropriate error' do
        expect(invoice.errors.full_messages).to include PRICE_RANGE_ERROR
      end
    end
  end

  describe '#usage' do
    context 'when no usage is given' do
      let(:usage) { nil }

      it 'is not valid' do
        expect(invoice).not_to be_valid
      end

      it 'has the appropriate error' do
        expect(invoice.errors.full_messages).to include NO_USAGE_ERROR
      end
    end

    context 'when an invalid usage is given' do
      let(:usage) { 1.1110000001 }

      it 'is not valid' do
        expect(invoice).not_to be_valid
      end

      it 'has the appropriate error' do
        expect(invoice.errors.full_messages).to include USAGE_FORMAT_ERROR
      end
    end

    context 'when a usage less than 0 is given' do
      let(:usage) { -2 }

      it 'is not valid' do
        expect(invoice).not_to be_valid
      end

      it 'has the appropriate error' do
        expect(invoice.errors.full_messages).to include USAGE_RANGE_ERROR
      end
    end
  end
end
