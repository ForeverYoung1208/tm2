class CreateOnlinedrivers < ActiveRecord::Migration
  def self.up
    create_table :onlinedrivers do |t|
      t.references :adriver
      t.references :odate
      
      t.timestamps
    end
  end

  def self.down
    drop_table :onlinedrivers
  end
end
