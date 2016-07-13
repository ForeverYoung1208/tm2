class CreateTelnumbers < ActiveRecord::Migration
	
  def change
    create_table :telnumbers do |t|
      t.string :tel_number
      t.references :user

      t.timestamps      
    end
  end

end
