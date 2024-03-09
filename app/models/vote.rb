class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :candidate
  has_many :vote_change_logs
end
