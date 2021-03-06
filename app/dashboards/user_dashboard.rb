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
    id: Field::Number,
    email: Field::String,
    password: Field::Password,
    password_confirmation: Field::Password,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    name: Field::String,
    suburb: Field::String,
    street_number_name: Field::String,
    role: Field::Select.with_options(collection: User::ROLE),
    postcode: Field::Number,
    breeder_supply_number: Field::Number,
    breeder_id_picture: Field::ActiveStorage,
    state: Field::String,
    stripe_payment_id: Field::String,
    application_status: Field::Select.with_options(collection: User::APPLICATION_STATUS),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  email
  name
  role
  listings
  application_status
  id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  listings
  id
  email
  created_at
  updated_at
  name
  suburb
  street_number_name
  role
  postcode
  breeder_supply_number
  breeder_id_picture
  state
  stripe_payment_id
  application_status
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  listings
  email
  name
  suburb
  street_number_name
  role
  postcode
  breeder_supply_number
  breeder_id_picture
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
