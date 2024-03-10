require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should create user' do
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { username: 'testuser', password: 'password' } }
    end

    assert_response :created
  end

  test 'should not create user with invalid params' do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { username: 'testuser' } }
    end

    assert_response :unprocessable_entity
  end
end
