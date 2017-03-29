require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::P24Transaction do

  subject { FactoryGirl.create :p24_transaction }

  it { is_expected.to have_many(:p24_confirmed_transactions) }

  it { is_expected.to validate_presence_of(:p24_merchant_id) }
  it { is_expected.to validate_presence_of(:p24_pos_id) }
  it { is_expected.to validate_presence_of(:p24_session_id) }
  it { is_expected.to validate_presence_of(:p24_amount) }
  it { is_expected.to validate_presence_of(:p24_currency) }
  it { is_expected.to validate_presence_of(:p24_description) }
  it { is_expected.to validate_presence_of(:p24_email) }
  it { is_expected.to validate_presence_of(:p24_country) }
  it { is_expected.to validate_presence_of(:p24_url_return) }
  it { is_expected.to validate_presence_of(:p24_api_version) }
  it { is_expected.to validate_presence_of(:p24_sign) }

  context "email" do

    it "is not valid" do
      subject.p24_email = 'xxx@'
      expect(subject.valid?).to be false
    end
  end

  describe '.confirm' do

    it 'sets confirmed as true' do
      subject.confirm
      expect(subject.confirmed).to be_truthy
    end
  end
end
