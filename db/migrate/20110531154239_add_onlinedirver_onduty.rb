class AddOnlinedirverOnduty < ActiveRecord::Migration
  def self.up
    change_table :onlineautos do |t|
      t.boolean :onduty
    end
  end

  def self.down
    change_table :onlineautos  do |t|
      t.remove :onduty
    end
  end
end
