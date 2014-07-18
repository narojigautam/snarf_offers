require 'offer'

module OffersParser
  def parse_into_objects res
    response = JSON.parse(res)
    offers_list = []
    response["offers"].each do |offer|
      offers_list << Offer.new(form_offer_hash(offer))
    end
    offers_list
  end

  def form_offer_hash(offer)
    {
      title: offer['title'],
      payout: offer['payout'],
      thumbnail: offer['thumbnail']['lowres']
    }
  end
end