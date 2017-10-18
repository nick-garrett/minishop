require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:line_1) { 'a' }
  let(:line_2) { 'b' }
  let(:line_3) { 'c' }
  let(:address) { Address.create(line_1: line_1, line_2: line_2, line_3: line_3, user_id: 1) }

  describe 'line_1 validation' do
    context 'when line_1 is not present' do
      let(:line_1) { nil }

      it 'is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when line_1 is present' do
      it 'is valid' do
        expect(address).to be_valid
      end
    end
  end

  describe 'line_2 validation' do
    context 'when line_2 is not present' do
      let(:line_2) { nil }

      it 'is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when line_2 is present' do
      it 'is valid' do
        expect(address).to be_valid
      end
    end
  end

  describe 'line_3 validation' do
    context 'when line_3 is not present' do
      let(:line_3) { nil }

      it 'is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when line_3 is present' do
      it 'is valid' do
        expect(address).to be_valid
      end
    end
  end
end
