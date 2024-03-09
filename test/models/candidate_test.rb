# frozen_string_literal: true

require 'test_helper'

class CandidateTest < ActiveSupport::TestCase
  test 'should not save candidate without name' do
    candidate = Candidate.new
    assert_not candidate.save, 'Saved the candidate without a name'
  end

  test 'should save candidate with name' do
    candidate = Candidate.new(name: 'Candidate A')
    assert candidate.save, true
  end
end
