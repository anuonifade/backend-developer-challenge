# frozen_string_literal: true

class CreateVoteChangeLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :vote_change_logs do |t|
      t.references :vote, foreign_key: true
      t.references :old_candidate, index: true, foreign_key: { to_table: :candidates }
      t.references :new_candidate, index: true, foreign_key: { to_table: :candidates }
      t.timestamps
    end
  end
end
