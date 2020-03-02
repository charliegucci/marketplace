require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    listings: Field::HasMany,
    breeder_id_picture_attachment: Field::HasOne,
    breeder_id_picture_blob: Field::HasOne,
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    name: Field::String,
    suburb: Field::String,
    street_number_name: Field::String,
    role: Field::String,
    postcode: Field::Number,
    breeder_supply_number: Field::Number,
    state: Field::String,
    application_status: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  listings
  breeder_id_picture_attachment
  breeder_id_picture_blob
  id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  listings
  breeder_id_picture_attachment
  breeder_id_picture_blob
  id
  email
  encrypted_password
  reset_password_token
  reset_password_sent_at
  remember_created_at
  created_at
  updated_at
  name
  suburb
  street_number_name
  role
  postcode
  breeder_supply_number
  state
  application_status
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  listings
  breeder_id_picture_attachment
  breeder_id_picture_blob
  email
  encrypted_password
  reset_password_token
  reset_password_sent_at
  remember_created_at
  name
  suburb
  street_number_name
  role
  postcode
  breeder_supply_number
  state
  application_status
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
