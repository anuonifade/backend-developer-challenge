# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, index: { unique: true }
      t.string :password_digest
      t.timestamps
    end
  end
end
