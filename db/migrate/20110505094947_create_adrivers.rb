class CreateAdrivers < ActiveRecord::Migration
  def self.up
    create_table :adrivers do |t|
      t.string :name
      t.string :autodesc
      t.string :autonumber

      t.timestamps
    end
  end

  def self.down
    drop_table :adrivers
  end
end
