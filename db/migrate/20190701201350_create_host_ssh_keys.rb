# frozen_string_literal: true

class CreateHostSshKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :host_ssh_keys do |t|
      t.string :username, null: false
      t.references :host, foreign_key: true
      t.references :ssh_key, foreign_key: true
      t.datetime :valid_from, null: false
      t.datetime :valid_to, null: false

      t.timestamps
    end
  end
end
