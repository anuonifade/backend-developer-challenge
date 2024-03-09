# frozen_string_literal: true

class VoteChangeLog < ApplicationRecord
  belongs_to :vote
  belongs_to :candidate
end
