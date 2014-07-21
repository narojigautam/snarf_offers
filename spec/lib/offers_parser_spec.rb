require "rails_helper"
require 'offers_parser'
require 'errors'

RSpec.describe OffersParser, :type => :module do
  let(:parser_class) { class OffersParserTest; extend OffersParser; end }

  context "#parse_into_objects" do
    let(:response) { sample_json_response }
    let(:expectation) { sample_parser_expectation }

    it "parses string response into meaningful Offer objects" do
      expect(parser_class.parse_into_objects(response).first.attributes).to eq expectation
    end
  end

  context "#parse_response_code" do
    let(:response) { invalid_page_json_response }

    it "raises InvalidPageException if entered page number is not valid" do
      expect { parser_class.parse_response_code(invalid_page_json_response) }.to raise_error Errors::InvalidPageException
    end
  end
end