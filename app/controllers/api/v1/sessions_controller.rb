# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate!

      def create
        user = User.find_by(username: login_params[:username])
        if user&.authenticate(login_params[:password])
          private_key = OpenSSL::PKey::RSA.new(File.read('private_key.pem'))
          payload = { user_id: user.id, exp: (ENV['TOKEN_EXP_IN_HOURS'] || 24).hours.from_now.to_i }
          token = JWT.encode(payload, private_key, 'RS256')
          render json: { token: }, status: :ok
        else
          render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:username, :password)
      end
    end
  end
end
