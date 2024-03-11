# frozen_string_literal: true

require 'test_helper'
require 'jwt'

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @candidate = candidates(:one)
    @token = generate_token({ user_id: @user.id, exp: 24.hours.from_now.to_i }) # Mocking JWT token generation
  end

  test 'should create vote' do
    post api_v1_votes_url, params: { vote: { candidate_id: @candidate.id } },
                           headers: { 'Authorization' => @token }
    assert_response :created
  end

  test 'should not create vote if user is unauthorized' do
    post api_v1_votes_url, params: { vote: { candidate_id: @candidate.id } },
                           headers: { 'Authorization' => 'invalid_token' }
    assert_response :unauthorized
  end

  private

  def generate_token(payload)
    private_key = OpenSSL::PKey::RSA.new(File.read('private_key.pem'))
    JWT.encode(payload, private_key, 'RS256')
  end
end
