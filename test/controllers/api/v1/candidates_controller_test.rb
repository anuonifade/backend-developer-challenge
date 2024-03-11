# frozen_string_literal: true

require 'test_helper'

class CandidatesControllerTest < ActionDispatch::IntegrationTest
  test 'should get vote count for candidate' do
    candidate = candidates(:one)
    vote_count = candidate.votes.count

    get "/api/v1/candidates/#{candidate.id}/vote_count"

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal candidate.name, json_response['candidate_name']
    assert_equal vote_count, json_response['vote_count']
  end

  test 'should get vote counts for all candidates' do
    get '/api/v1/candidates/vote_counts'

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response

    candidates = Candidate.all
    candidates.each do |candidate|
      assert_includes json_response, { 'candidate_name' => candidate.name, 'vote_count' => candidate.votes.count }
    end
  end
end
