# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should log in user with valid credentials' do
    users(:one)
    post api_v1_login_url, params: { username: 'user1', password: 'password' }
    assert_response :success
  end

  test 'should not log in user with invalid credentials' do
    users(:one)
    post api_v1_login_url, params: { user: { username: 'invaliduser', password: 'invalidpassword' } }
    assert_response :unauthorized
  end
end
