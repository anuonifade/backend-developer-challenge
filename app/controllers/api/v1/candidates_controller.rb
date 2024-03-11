# frozen_string_literal: true

module Api
  module V1
    class CandidatesController < ApplicationController
      skip_before_action :authenticate!

      def vote_count
        candidate = Candidate.find(params[:id])
        vote_count = candidate.votes.count

        render json: { candidate_name: candidate.name, vote_count: }, status: :ok
      end

      def vote_counts_all
        candidates = Candidate.all
        vote_counts = candidates.map do |candidate|
          { candidate_name: candidate.name, vote_count: candidate.votes.count }
        end

        render json: vote_counts, status: :ok
      end
    end
  end
end
