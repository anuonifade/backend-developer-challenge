# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true, index: { unique: true }
      t.references :candidate, foreign_key: true
      t.timestamps
    end
  end
end
