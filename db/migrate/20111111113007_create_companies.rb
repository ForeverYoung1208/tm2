class CreateCompanies < ActiveRecord::Migration[5.2]
  def self.up
    create_table :companies do |t|
      t.string :name
      t.boolean :istabelling

      t.timestamps
    end

    #добавляем зависимость пользователям
    change_table :users do |t|
      t.references :company
    end


  end

  def self.down

    change_table :users do |t|
      t.remove :company
    end

    drop_table :companies
  end
end
