# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :candidate
  has_many :vote_change_logs

  validates_presence_of :user
  validates_presence_of :candidate

  after_save :create_vote_change_log

  def create_vote_change_log
    old_candidate_id = attribute_changed?('candidate_id') ? previous_changes['candidate_id'][0] : nil

    vote_change_logs.create(old_candidate_id:,
                            new_candidate_id: candidate_id)
  end
end
