require "rails_helper"
require 'offers_parser'

RSpec.describe OffersParser, :type => :module do
  let(:parser_class) { class OffersParserTest; extend OffersParser; end }

  context "#parse_into_objects" do
    let(:response) { sample_json_response }
    let(:expectation) { sample_parser_expectation }

    it "parses string response into meaningful Offer objects" do
      expect(parser_class.parse_into_objects(response).first.attributes).to eq expectation
    end
  end
end