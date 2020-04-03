class AddFkOrdersAutos < ActiveRecord::Migration[5.2]
  def self.up

    change_table :aorders do |t|
      t.references :aauto
    end

  end

  def self.down

    change_table :aorders do |t|
      t.remove :aauto
    end

  end
end
