require 'rails_helper'

NO_PRICE_ERROR = "Price can't be blank".freeze

RSpec.describe Invoice, type: :model do
  fixtures :users

  let(:user) { users(:user) }
  let(:invoice) { user.invoices.create(price: price, usage: usage) }
  let(:price) { 10.00 }
  let(:usage) { 5.4321 }

  describe 'price' do
    context 'when no price is given when creating an invoice' do
      let(:price) { nil }

      it 'is not valid' do
        expect(invoice).not_to be_valid
      end

      it 'has appropriate error' do
        expect(invoice.errors.full_messages).to include NO_PRICE_ERROR
      end
    end
  end
end
