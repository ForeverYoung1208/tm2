class AddAutoContact < ActiveRecord::Migration[5.2]
  def self.up
    change_table :aautos do |t|
      t.string :contact
    end

  end

  def self.down
    change_table :aautos do |t|
      t.remove :contact
    end

  end
end
