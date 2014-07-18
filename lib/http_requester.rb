require 'net/http'

module HttpRequester
  def get(url)
    result = Net::HTTP.get(URI.parse(url))
  end
end
