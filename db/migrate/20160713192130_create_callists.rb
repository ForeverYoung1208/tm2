class CreateCallists < ActiveRecord::Migration
  def change
    create_table :callists do |t|
      t.text :data, limit: 16777215
      t.string :filename
      t.references :loadedby
      t.boolean :isparsed

      t.timestamps
    end
    add_index :callists, :loadedby_id
  end
end
