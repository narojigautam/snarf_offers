# Class to represent each offer we support in our app
class Offer
  include Virtus.model

  attribute :title, String
  attribute :payout, String
  attribute :thumbnail, String
end