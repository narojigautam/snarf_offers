require "rails_helper"
require "http_requester"
require 'webmock/rspec'

RSpec.describe HttpRequester, :type => :module do

  let(:requester_class) { class HttpRequesterTest; extend HttpRequester; end }

  context "#get", vcr_off: true do
    let(:url)         { "http://www.example.com" }

    before do
      stub_request(:get, "http://www.example.com").to_return(:body => "success", :status => 200)
    end

    it "makes a GET request" do
      requester_class.get(url)
      WebMock.should have_requested(:get, "http://www.example.com")
    end
  end

end
