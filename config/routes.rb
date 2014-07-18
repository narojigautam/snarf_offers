SnarfOffers::Application.routes.draw do
  root 'home#index'

  post '/offers' => 'home#offers', as: :query_offers
end
