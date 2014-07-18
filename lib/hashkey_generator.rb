require 'digest/sha1'

module HashkeyGenerator

  # create a string representation of passed hash, which can be encoded in a URL
  def concat_params(params)
    @result = ""
    return @result if params.empty?
    params.map{|key,val| @result += "#{key}=#{val}&" if val.present?}
    @result.chomp!('&')
  end

  # sort the parameters in alphabetical order of keys
  def sort_params(params)
    Hash[params.sort]
  end

  # Generate a hashkey using SHA1
  def generate_hashkey_for(source)
    Digest::SHA1.hexdigest source
  end
end
