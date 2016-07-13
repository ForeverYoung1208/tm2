class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :tel_number
      t.string :datetime
      t.string :calltype
      t.string :direction
      t.integer :dest_number
      t.integer :duration
      t.decimal :cost_bal, :precision => 15, :scale => 2
      t.decimal :cost_nodiscount, :precision => 15, :scale => 2
      t.references :user

      t.timestamps
    end
    add_index :calls, :user_id
  end

end
