require 'offer'
require 'errors'

module OffersParser

  # this method parses a response from Offers API call into Offer objects
  def parse_into_objects res
    response = JSON.parse(res)
    offers_list = []
    parse_response_code(response)
    response["offers"].present? and response["offers"].each do |offer|
      offers_list << Offer.new(form_offer_hash(offer))
    end
    offers_list
  end

  def form_offer_hash(offer)
    {
      title: offer['title'],
      payout: offer['payout'],
      thumbnail: offer['thumbnail']['lowres'],
      image: offer['thumbnail']['hires'],
      teaser: offer['teaser'],
      time_to_payout: offer['time_to_payout']['readable']
    }
  end

  def parse_response_code(response)
    case response["code"]
    when "ERROR_INVALID_PAGE"
      Rails.logger.error Errors::InvalidPageException
      true
    else
      true
    end
  end
end