class AddDepartmentToAorder < ActiveRecord::Migration[5.2]
  def change 
  	change_table :aorders do |t| 
    	t.references :department
    end
  end
end
