class CreateOnlineautos < ActiveRecord::Migration
  def self.up
    create_table :onlineautos do |t|
      t.references :aauto
      t.references :odate
      
      t.timestamps
    end
  end

  def self.down
    drop_table :onlineautos
  end
end
