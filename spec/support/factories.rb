require 'offer_api'
require 'offer'

module Factories
  def valid_offer_instance
    OfferApi.new appid: 157, uid: :snarfinator, locale: :de,
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      ip: '109.235.143.113', offer_types: 112, page: 1
  end

  def sample_json_response
    '{"offers":[{"title":"Snarf","payout":"whats that","thumbnail":"url_to_thumbnail"}]}'
  end

  def sample_parser_expectation
    {title: "Snarf", payout: "whats that", thumbnail: "url_to_thumbnail"}
  end
end

RSpec.configure do |c|
  c.include Factories
end
