class AddDriverContact < ActiveRecord::Migration
  def self.up
    change_table :adrivers do |t|
      t.string :contact
    end

  end

  def self.down
    change_table :adrivers do |t|
      t.remove :contact
    end

  end
end
