require 'http_requester'
require 'hashkey_generator'

class Offer
  include HttpRequester
  include HashkeyGenerator
  include ActiveModel::Validations
  include Virtus.model

  attr_accessor :base_url
  @@base_url = "http://api.sponsorpay.com"

  def timestamp
    @stamp ||= DateTime.now.to_i
  end

  def timestamp= value
    @stamp = value
  end

  def api_key
    @key ||= "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
  end

  def api_key= value
    @key = value
  end

  attribute :format, String, default: :json
  attribute :appid, Integer
  attribute :uid, String
  attribute :locale, String, default: :de
  attribute :os_version, Float, default: 6.0
  attribute :hashkey, String
  attribute :pub0, String
  attribute :page, Integer, default: 1
  attribute :offer_types, String
  attribute :device_id, String
  attribute :ip, String

  validates_presence_of :format, :appid, :uid, :locale, :os_version

  def find(page = 1)
    @page = page
    timestamp = DateTime.now.to_i
    offers_response = get(offers_url)
  end

  def offers_url
    offers_url_part = "/feed/v1/offers.json"
    "#{@@base_url}#{offers_url_part}?#{req_attributes}"
  end

  def req_attributes
    "#{concat_params(time_stamped_attributes)}&hashkey=#{get_hashkey}"
  end

  def get_hashkey
    @hash_key ||= generate_hashkey_for(sorted_api_encoded_attributes_string)
  end

  def sorted_api_encoded_attributes_string
    "#{concat_params(sort_params(time_stamped_attributes))}&#{api_key}"
  end

  def time_stamped_attributes
    attributes.merge(timestamp: timestamp)
  end
end