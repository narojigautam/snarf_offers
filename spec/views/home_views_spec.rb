require "rails_helper"

RSpec.describe "home/index", :type => :view do
  it "renders search form to query for offers" do
    render
    expect(rendered).to include("Get Offers")
    expect(rendered).to include("User ID")
    expect(rendered).to include("Custom Field")
    expect(rendered).to include("Page")
  end
end