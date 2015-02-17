class CreateAautos < ActiveRecord::Migration
  def self.up
    create_table :aautos do |t|
      t.string :name
      t.string :autodesc
      t.string :autonumber

      t.timestamps
    end
  end

  def self.down
    drop_table :aautos
  end
end
