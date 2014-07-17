require 'net/http'

class HttpRequester
  def self.get(url, params = {})
    result = Net::HTTP.get(URI.parse(url + concat_params(params)))
  end

  def self.concat_params(params)
    return "" if params.empty?
    result = "?"
    params.map{|key,val| result += "#{key}=#{val}&"}
    result.chomp!('&')
  end
end
