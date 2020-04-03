class CreateUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_hash
      t.string :password_salt
      t.references :userlevel

      t.timestamps
    end

    change_table :aorders do |t|
      t.references :user
    end

  end

  def self.down
    change_table :aorders do |t|
      t.remove :user_id
    end
    drop_table :users
  end

end
