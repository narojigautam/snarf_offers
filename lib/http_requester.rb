# This module takes care of Http Request specific tasks

module HttpRequester
  def get(url)
    response = HTTParty.get(URI.encode(url))
    response_header = response.header
    response_sign = response.headers['x-sponsorpay-response-signature']
    { response_sign: response_sign, response_body: response.body }
  end
end
