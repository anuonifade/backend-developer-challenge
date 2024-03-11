# frozen_string_literal: true

class CastVote
  attr_reader :user, :params, :errors

  def initialize(user, params)
    @user = user
    @params = params
    @errors = []
  end

  # rubocop:disable Metrics/MethodLength
  def call
    return false if user_has_exceeded_vote_changes?

    vote = Vote.find_or_initialize_by(user_id: user.id)
    if vote.new_record? || vote_change_within_24_hours?(vote)
      vote.candidate_id = params[:candidate_id]
      if vote.save
        true
      else
        @errors = vote.errors.full_messages
        false
      end
    else
      @errors = ['User has already changed vote more than 2 times in the last 24 hours']
      false
    end
  end
  # rubocop:enable Metrics/MethodLength

  private

  def user_has_exceeded_vote_changes?
    vote = user&.vote
    return false unless vote.present?

    VoteChangeLog.where('vote_id = ? AND created_at >= ?', vote.id, 24.hours.ago).count >= 2
  end

  def vote_change_within_24_hours?(vote)
    vote.new_record? || VoteChangeLog.where('vote_id = ? AND created_at >= ?', vote.id, 24.hours.ago).count < 2
  end
end
