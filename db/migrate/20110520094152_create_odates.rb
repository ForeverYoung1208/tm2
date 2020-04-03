class CreateOdates < ActiveRecord::Migration[5.2]
  def self.up
    create_table :odates do |t|
      t.date :thedate
      t.boolean :isclosed

      t.timestamps
    end

    change_table :aorders do |t|
      t.references :odate
    end

  end

  def self.down
    drop_table :odates
    change_table :aorders do |t|
      t.remove :odate
    end

  end
end
