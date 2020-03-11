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

    # I can see the page for Available Listings
    assert_text "Available"
    assert_text "Listings"

    # ... and see listings based on the search term
    within '.search-results' do
      assert_text 'Mastiff'
      assert_text 'Bullmastiff'
    end
  end
end
