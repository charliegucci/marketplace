require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url

    assert_selector "input#search"
  end

  test "searching for listing" do
    visit root_url

    within 'form#search-bar' do
      find("input#search").fill_in(with: "Mastiff")
      click_on "Search"
    end

    assert_text "Available"
    assert_text "Listings"
 end
end
