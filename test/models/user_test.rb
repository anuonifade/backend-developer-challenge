# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without username' do
    user = User.new(password_digest: 'password')
    assert_not user.save, 'Saved the user without a username'
  end

  test 'should not save user without password_digest' do
    user = User.new(username: 'testuser')
    assert_not user.save, 'Saved the user without a password_digest'
  end

  test 'should save user with username and password_digest' do
    user = User.new(username: 'testuser', password_digest: 'password')
    assert user.save, true
  end
end
