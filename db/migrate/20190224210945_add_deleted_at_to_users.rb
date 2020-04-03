class AddDeletedAtToUsers < ActiveRecord::Migration[5.2]

  def change 
  	change_table :users do |t| 
    	t.datetime :deleted_at
    end
  end

end
