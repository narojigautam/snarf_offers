require "rails_helper"
require "offer_api"

RSpec.describe OfferApi, :type => :class do

  context "#valid?" do
    let(:offers) { OfferApi.new }
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
      VCR.use_cassette('offers_list2') do
        offers_res = offers.find
        expect(offers_res).to_not be_empty
      end
    end
  end

  context "#offers_url" do
    let(:offers)      { OfferApi.new(appid: 123) }
    let(:expectation) { "http://api.sponsorpay.com/feed/v1/offers.json?format=json&appid=123&locale=de&os_version=6.0&page=1&timestamp=1405681698&hashkey=snarf-key" }

    before do
      OfferApi.any_instance.stub(:get_hashkey).and_return("snarf-key")
      offers.timestamp = 1405681698
    end

    it "returns the correct offers url" do
      expect(offers.offers_url).to eq expectation
    end
  end

  context "#req_attributes" do
    let(:offers) { OfferApi.new(appid: 123, locale: :en, uid: '233') }
    let(:attr_expectation) { "format=json&appid=123&uid=233&locale=en&os_version=6.0&page=1&timestamp=1405681773" }

    before do
      OfferApi.any_instance.stub(:get_hashkey).and_return("snarf-key")
      offers.timestamp = 1405681773
    end

    it "returns the url encoded attributes of the Offer instance together with generated hashkey" do
      expect(offers.req_attributes).to eq "#{attr_expectation}&hashkey=snarf-key"
    end
  end

  context "#sorted_api_encoded_attributes_string" do
    let(:offers) { OfferApi.new(appid: 123) }

    it "returns an api key encoded url" do
      offers.api_key = '1234'
      offers.timestamp = 1405681972
      expectation = 'appid=123&format=json&locale=de&os_version=6.0&page=1&timestamp=1405681972&1234'
      expect(offers.sorted_api_encoded_attributes_string).to eq expectation
    end
  end

  context "#time_stamped_attributes" do
    let(:offers) { OfferApi.new(appid: 123) }

    it "returns attributes of OffersAPI object hash mixed with timestamp" do
      expect(offers.attributes).to_not include :timestamp
      expect(offers.time_stamped_attributes.keys).to include :timestamp
    end
  end
end
