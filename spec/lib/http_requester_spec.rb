require "rails_helper"
require "http_requester"
require 'webmock/rspec'

RSpec.describe HttpRequester, :type => :class do

  context "#get", vcr_off: true do
    let(:url)         { "http://www.example.com" }
    let(:params)      { {} }

    before do
      stub_request(:get, "http://www.example.com").to_return(:body => "success", :status => 200)
    end

    it "makes a GET request" do
      HttpRequester.get(url, params)
      WebMock.should have_requested(:get, "http://www.example.com")
    end
  end

  context "#concat_params" do
    let(:params)      { {operation: :add, operand_a: 1, operand_b: 2 } }
    let(:expectation) { "?operation=add&operand_a=1&operand_b=2" }
    it "can concat has params as a get url part" do
      expect(HttpRequester.concat_params(params)).to eq expectation
    end

    it "returns empty string is empty params hash ispassed" do
      expect(HttpRequester.concat_params({})).to eq ""
    end
  end
end
