require 'offer'
module Factories
  def valid_offer_instance
    Offer.new appid: 157, uid: :snarfinator, locale: :de,
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      ip: '109.235.143.113', offer_types: 112, page: 1
  end
end

RSpec.configure do |c|
  c.include Factories
end
