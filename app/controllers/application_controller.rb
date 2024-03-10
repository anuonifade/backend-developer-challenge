class ApplicationController < ActionController::API
  before_action :authenticate!

  def authenticate!
    token = extract_token
    render json: { error: 'Unauthorized' }, status: :unauthorized unless token
    decoded_token = decode_token(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless decoded_token
    @current_user = User.find(decoded_token['user_id'])
  rescue JWT::DecodeError => e
    render json: { error: e.message }, status: :unauthorized
  end

  private

  def extract_token
    header = request.headers['Authorization']
    header.split(' ').last if header.present?
  end

  def decode_token(token)
    public_key = OpenSSL::PKey::RSA.new(File.read('public_key.pem'))
    JWT.decode(token, public_key, true, algorithm: 'RS256').first
  end
end
