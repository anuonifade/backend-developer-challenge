# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :candidate
  has_many :vote_change_logs

  validates_presence_of :user
  validates_presence_of :candidate
end
