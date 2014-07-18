require 'offer_api'

class HomeController < ApplicationController
  def offers
    offer_api = OfferApi.new(params[:offer_api])
    unless offer_api.valid?
      flash[:error] = "Errors : #{clean_messages(offer_api.errors.messages)}"
      render :index and return
    end
    @offers = offer_api.find
    render :list_offers
  end

  private

  def clean_messages messages
    message_list = []
    messages.map{|key, val| message_list << "#{key} #{val.join(", ")}."}
    message_list.join(" ")
  end
end
