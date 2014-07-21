module Errors
  # Error to define compromised api provider based on signed responses
  class WrongSignatureException < Exception
    def message
      "Response is signed with a wrong signature. Source of Offers has been compromised."
    end
  end

  class InvalidPageException < Exception
    def message
      "You have entered an invalid page number."
    end
  end
end