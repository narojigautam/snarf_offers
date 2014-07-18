require "rails_helper"
require "offer"

RSpec.describe Offer, :type => :class do

  context "#valid?" do
    let(:offers) { Offer.new }
    let(:params) { {format: :test, appid: 111, uid: :test, locale: :test,
      os_version: 6.0} }

    it "validates presence of required fields" do
      expect(offers.valid?).to be_falsy
      offers.attributes = params
      expect(offers.valid?).to be_truthy
    end
  end

  context "#find" do
    let!(:offers) { valid_offer_instance }

    it "returns a list of offers" do
      offers.timestamp = 1405683773
      VCR.use_cassette('offers_list') do
        response = JSON.parse(offers.find())
        res_mesg = response['message']
        expect(res_mesg).to eq "Successful request, but no offers are currently available for this user."
      end
    end
  end

  context "#offers_url" do
    let(:offers)      { Offer.new(appid: 123) }
    let(:expectation) { "http://api.sponsorpay.com/feed/v1/offers.json?format=json&appid=123&locale=de&os_version=6.0&page=1&timestamp=1405681698&hashkey=snarf-key" }

    before do
      Offer.any_instance.stub(:get_hashkey).and_return("snarf-key")
      offers.timestamp = 1405681698
    end

    it "returns the correct offers url" do
      expect(offers.offers_url).to eq expectation
    end
  end

  context "#req_attributes" do
    let(:offers) { Offer.new(appid: 123, locale: :en, uid: '233') }
    let(:attr_expectation) { "format=json&appid=123&uid=233&locale=en&os_version=6.0&page=1&timestamp=1405681773" }

    before do
      Offer.any_instance.stub(:get_hashkey).and_return("snarf-key")
      offers.timestamp = 1405681773
    end

    it "returns the url encoded attributes of the Offer instance together with generated hashkey" do
      expect(offers.req_attributes).to eq "#{attr_expectation}&hashkey=snarf-key"
    end
  end

  context "#sorted_api_encoded_attributes_string" do
    let(:offers) { Offer.new(appid: 123) }

    it "returns an api key encoded url" do
      offers.base_url = 'http://www.snarf.com'
      offers.api_key = '1234'
      offers.timestamp = 1405681972
      expectation = 'appid=123&format=json&locale=de&os_version=6.0&page=1&timestamp=1405681972&1234'
      expect(offers.sorted_api_encoded_attributes_string).to eq expectation
    end
  end
end
