SnarfOffers::Application.routes.draw do
  root 'home#index'

  get '/offers' => 'home#offers', as: :query_offers
end
