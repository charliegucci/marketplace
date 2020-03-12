require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include ActionMailer::TestHelper

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

  test "contacting a seller" do
    sign_in users(:guest_user)

    visit root_url

    within 'form#search-bar' do
      find("input#search").fill_in(with: "Mastiff")
      click_on "Search"
    end

    within '.search-results' do
      find_all('a', text: 'Price: Contact Seller').first.click
    end

    within 'form' do
      fill_in('buyer_message[buyer_name]', with: 'Doris Jacobs')
      fill_in('buyer_message[buyer_email]', with: 'guest@g.com')
      fill_in('buyer_message[body]', with: "I'm interested in your dog. How can I get more info?")
      assert_emails 1 do
        click_on 'Send Message'
      end

      new_message = Buyer::Message.where(buyer_email: 'guest@g.com').first

      assert_not_nil new_message
      assert_equal new_message.buyer_email, 'guest@g.com'
      assert_equal new_message.buyer_name, 'Doris Jacobs'
      assert_equal new_message.body, "I'm interested in your dog. How can I get more info?"
    end

    assert_text 'Message was successfully sent'
  end
  # I was able to go to homepage, type "mastiff" click search, look for any matching, click on the contact seller button,
  # fill in the form and send message and able to check if email went thru.
end
