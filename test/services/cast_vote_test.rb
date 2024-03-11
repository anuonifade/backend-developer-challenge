# frozen_string_literal: true

require 'test_helper'

class CastVoteTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @candidate = candidates(:one)
    @candidate2 = candidates(:two)
    @valid_params = { candidate_id: @candidate.id }
    @valid_params_c2 = { candidate_id: @candidate2.id }
  end

  test 'should create vote for user with no previous vote' do
    service = CastVote.new(@user, @valid_params)
    assert service.call
    assert_equal 1, Vote.where(user: @user).count
  end

  test 'should update vote for user within 24 hours' do
    Vote.create(user_id: @user.id, candidate_id: @candidate.id)

    service = CastVote.new(@user, @valid_params_c2)
    assert service.call
    assert_equal @candidate2.id, @user.reload.vote.candidate_id
  end

  test 'should not update vote for user with 2 changes within 24 hours' do
    vote = Vote.create(user_id: @user.id, candidate_id: @candidate.id)
    2.times do
      vote.update(updated_at: Time.now - 23.hours) # Update the vote within 24 hours
    end

    service = CastVote.new(@user, @valid_params_c2)
    assert_not service.call
    assert_not_equal @candidate2.id, @user.reload.vote.candidate_id
  end

  test 'should not update vote for user with more than 2 changes within 24 hours' do
    vote = Vote.create(user_id: @user.id, candidate_id: @candidate.id)
    3.times do
      vote.update(updated_at: Time.now - 23.hours) # Update the vote within 24 hours
    end

    service = CastVote.new(@user, @valid_params_c2)
    assert_not service.call
    assert_not_equal @candidate2.id, @user.reload.vote.candidate_id
  end

  test 'should not create vote for invalid parameters' do
    service = CastVote.new(@user, {})
    assert_not service.call
    assert_equal ['Candidate must exist', "Candidate can't be blank"], service.errors
  end
end
