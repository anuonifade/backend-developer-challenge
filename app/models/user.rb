# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one :vote

  validates_presence_of :username
  validates_presence_of :password_digest
end
