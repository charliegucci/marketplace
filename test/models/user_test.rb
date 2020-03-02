require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def valid_user
    User.create(email: 't@g.com',
                password: 'asdfasdf',
                password_confirmation: 'asdfasdf',
                application_status: 'not_applied')
  end

  test "user is valid" do
    assert valid_user.valid?
  end

  test 'user roles' do
    user =  valid_user
    assert user.valid?

    user.role = 'gibberish'
    assert_not user.valid?

    user.role = 'guest'
    assert user.valid?

    user.role = 'seller'
    assert user.valid?

    user.role = 'admin'
    assert user.valid?
  end

  test "user with valid/invalid application_status" do
    user =  valid_user
    assert user.valid?

    user.application_status = 'gibberish'
    assert_not user.valid?

    user.application_status = 'not_applied'
    assert user.valid?

    user.application_status = 'pending'
    assert user.valid?

    user.application_status = 'approved'
    assert user.valid?

    user.application_status = 'rejected'
    assert user.valid?

    user.application_status = 'completed'
    assert user.valid?
  end

end
