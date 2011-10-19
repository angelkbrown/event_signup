class CreateRsvps < ActiveRecord::Migration
  def self.up
    create_table :rsvps do |t|
      t.string :shirt_size
      t.references :user
      t.references :section
      t.references :event

      t.timestamps
    end
  end

  def self.down
    drop_table :rsvps
  end
end
