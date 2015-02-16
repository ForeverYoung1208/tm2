class AddFkOrdersDrivers < ActiveRecord::Migration
  def self.up

    change_table :aorders do |t|
      t.references :adriver
    end

  end

  def self.down

    change_table :aorders do |t|
      t.remove :adriver
    end

  end
end
