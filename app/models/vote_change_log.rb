# frozen_string_literal: true

class VoteChangeLog < ApplicationRecord
  belongs_to :vote
  belongs_to :candidate,
             foreign_key: :old_candidate_id
  belongs_to :candidate,
             foreign_key: :new_candidate_id

  validates_presence_of :vote
end
