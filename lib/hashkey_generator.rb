require 'digest/sha1'

module HashkeyGenerator

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

  def generate_hashkey_for(source)
    Digest::SHA1.hexdigest source
  end
end
