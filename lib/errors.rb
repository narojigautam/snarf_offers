module Errors
  class WrongSignatureException < Exception
    def message
      "Response is signed with a wrong signature. Source of Offers have bee compromised."
    end
  end
end