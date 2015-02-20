class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.references :company

      t.timestamps
    end
    add_index :departments, :company_id
  end
end
