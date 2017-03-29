require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::P24ConfirmedTransaction do

  subject { FactoryGirl.create :p24_confirmed_transaction }

  it { is_expected.to validate_presence_of(:p24_merchant_id) }
  it { is_expected.to validate_presence_of(:p24_pos_id) }
  it { is_expected.to validate_presence_of(:p24_session_id) }
  it { is_expected.to validate_presence_of(:p24_amount) }
  it { is_expected.to validate_presence_of(:p24_currency) }
  it { is_expected.to validate_presence_of(:p24_order_id) }
  it { is_expected.to validate_presence_of(:p24_method) }
  it { is_expected.to validate_presence_of(:p24_statement) }
  it { is_expected.to validate_presence_of(:p24_sign) }

  describe '.set_as_verified' do

    it 'sets verified as true' do
      subject.set_as_verified
      expect(subject.verified).to be_truthy
    end
  end
end
