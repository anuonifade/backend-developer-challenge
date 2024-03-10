# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate!

  def index
    render json: { message: 'Welcome to Voting App API' }, status: :ok
  end
end
