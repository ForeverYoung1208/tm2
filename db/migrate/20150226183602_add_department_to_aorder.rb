class AddDepartmentToAorder < ActiveRecord::Migration
  def change 
  	change_table :aorders do |t| 
    	t.references :department
    end
  end
end
