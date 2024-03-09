# frozen_string_literal: true

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'should not save vote without user' do
    vote = Vote.new(candidate: candidates(:one))
    assert_not vote.save, 'Saved the vote without a user'
  end

  test 'should not save vote without candidate' do
    vote = Vote.new(user: users(:one))
    assert_not vote.save, 'Saved the vote without a candidate'
  end

  test 'should save vote with user, candidate, and vote category' do
    vote = Vote.new(user: users(:one), candidate: candidates(:two))
    assert vote.save, true
  end
end
