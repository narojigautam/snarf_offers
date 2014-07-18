require 'http_requester'
require 'hashkey_generator'
require 'offers_parser'
require 'errors'

# This is the main class that makes the API calls to Offers API
class OfferApi
  include HttpRequester
  include HashkeyGenerator
  include OffersParser
  include ActiveModel::Validations
  include Virtus.model
  include Errors

  attr_accessor :base_url
  @@base_url = "http://api.sponsorpay.com"

  def timestamp
    @stamp ||= DateTime.now.to_i
  end

  def timestamp= value
    @stamp = value
  end

  # ToDo move key to a YML file and load it from there
  def api_key
    @key ||= "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
  end

  def api_key= value
    @key = value
  end

  attribute :format, String, default: :json
  attribute :appid, Integer, default: 157
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

  # The following method makes the Offers API call
  # It uses the url which has hashkey generated specifically to authenticate the call
  #
  def find
    timestamp = DateTime.now.to_i
    offers_response = get(offers_url)
    # No need to test Signed responses for test environment
    if Rails.env != "test" and !response_correctly_signed?(offers_response[:response_sign], offers_response[:response_body])
      raise WrongSignatureException
    end
    parse_into_objects offers_response[:response_body]
  end

  # API endpoint to the Offers API call
  def offers_url
    offers_url_part = "/feed/v1/offers.json"
    "#{@@base_url}#{offers_url_part}?#{req_attributes}"
  end

  # a URL encoded representation of parameters to be sent with the API call
  # it also has the Hashkey generated to authenticate the call
  def req_attributes
    "#{concat_params(time_stamped_attributes)}&hashkey=#{get_hashkey}"
  end

  # generate the Hashkey to be sent to authenticate the API call
  # needs a URL encoded parameters list which are sorted in alphabetical order of keys
  # also needs the API key provided for authentication
  def get_hashkey
    @hash_key ||= generate_hashkey_for(sorted_api_encoded_attributes_string)
  end

  def sorted_api_encoded_attributes_string
    "#{concat_params(sort_params(time_stamped_attributes))}&#{api_key}"
  end

  # add current timestamp to the params to be sent with API request
  def time_stamped_attributes
    attributes.merge(timestamp: timestamp)
  end

  # check if the response is correctly signed and is from a trusted source to which call was made
  def response_correctly_signed? response_sign, response_body
    generate_hashkey_for(response_body + api_key) == response_sign
  end
end