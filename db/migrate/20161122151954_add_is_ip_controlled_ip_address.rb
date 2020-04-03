class AddIsIpControlledIpAddress < ActiveRecord::Migration[5.2]

  def self.up
  	change_table :users do |t|
  		t.boolean :is_ip_controlled, :default => false
  		t.string :ip_address
  	end
  end

  def self.down
  	change_table :users do |t|
  		t.remove :is_ip_controlled
  		t.remove :ip_address
  	end
  end


end
