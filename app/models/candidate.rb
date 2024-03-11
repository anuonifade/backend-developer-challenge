# frozen_string_literal: true

class Candidate < ApplicationRecord
  has_many :votes
  has_many :vote_change_logs

  validates_presence_of :name
end
