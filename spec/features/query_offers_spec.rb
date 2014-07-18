require "rails_helper"

describe "query for offers for a user", :type => :feature do
  before :each do
    OfferApi.any_instance.stub(:timestamp).and_return(1405695485)
    visit root_path
  end

  it "displays the offers returned from a query" do
    within("#query-form") do
      fill_in 'offer_api_uid', :with => 'Snarf Me'
      fill_in 'offer_api_pub0', :with => 'Test Campaign'
      fill_in 'offer_api_page', :with => "1"
    end
    VCR.use_cassette('offers_list3') do
      click_button 'Submit'
      expect(page).to have_content 'Listing 30 Offers'
    end
  end

  it "displays no offers message for empty offers" do
    within("#query-form") do
      fill_in 'offer_api_uid', :with => 'Snarf Me'
      fill_in 'offer_api_pub0', :with => 'Test Campaign'
      fill_in 'offer_api_page', :with => "1"
    end
    VCR.use_cassette('offers_list4') do
      click_button 'Submit'
      expect(page).to have_content 'No offers'
    end
  end
end