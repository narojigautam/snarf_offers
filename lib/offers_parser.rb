require 'offer'

module OffersParser
  def parse_into_objects res
    response = JSON.parse(res)
    offers_list = []
    response["offers"].each do |offer_hash|
      offers_list << Offer.new(offer_hash)
    end
    offers_list
  end
end