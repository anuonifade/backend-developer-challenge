# frozen_string_literal: true

module Api
  module V1
    class VotesController < ApplicationController
      before_action :authenticate!

      def create
        service = CastVote.new(@current_user, vote_params)
        if service.call
          render json: { message: 'Vote cast successfully' }, status: :created
        else
          render json: { error: service.errors }, status: :unprocessable_entity
        end
      end

      private

      def vote_params
        params.require(:vote).permit(:candidate_id)
      end
    end
  end
end
