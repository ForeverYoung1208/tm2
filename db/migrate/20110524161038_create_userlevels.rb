class CreateUserlevels < ActiveRecord::Migration
  def self.up
    create_table :userlevels do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :userlevels
  end
end
