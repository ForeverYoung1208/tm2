class CreateAorders < ActiveRecord::Migration
  def self.up
    create_table :aorders do |t|
      t.date :ondate
      t.string :onname
      t.time :ftime
      t.time :totime
      t.integer :auto_id

      t.timestamps
    end
  end

  def self.down
    drop_table :aorders
  end
end
