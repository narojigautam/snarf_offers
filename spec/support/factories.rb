require 'offer_api'
require 'offer'

module Factories
  def valid_offer_instance
    OfferApi.new appid: 157, uid: :snarfinator, locale: :de,
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      ip: '109.235.143.113', offer_types: 112, page: 1
  end

  def sample_json_response
    '{"offers":[{"title":"Dalia Research-Your Opinion Counts","offer_id":294680,"teaser":"Answer the questions and receive your reward.","required_actions":"Answer the questions and receive your reward.","link":"http://api.sponsorpay.com/27c006835820c32c796152eef09f2582/ceb32e3197259a0c/mobile/IN/157/offers/294680","offer_types":[{"offer_type_id":110,"readable":"Umfragen"},{"offer_type_id":112,"readable":"Gratis"}],"payout":8147,"time_to_payout":{"amount":1800,"readable":"30 Minuten"},"thumbnail":{"lowres":"http://cdn2.sponsorpay.com/assets/14986/Survey1_square_60.jpg","hires":"http://cdn2.sponsorpay.com/assets/14986/Survey1_square_175.jpg"},"store_id":""}]}'
  end

  def sample_parser_expectation
    {title: "Dalia Research-Your Opinion Counts", payout: "8147", thumbnail: "http://cdn2.sponsorpay.com/assets/14986/Survey1_square_60.jpg"}
  end

  def invalid_page_json_response
    {"code" => "ERROR_INVALID_PAGE"}
  end
end

RSpec.configure do |c|
  c.include Factories
end
