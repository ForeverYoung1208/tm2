class AddWasUsedToOdates < ActiveRecord::Migration[5.2]
  def change
    add_column :odates, :was_used, :boolean, :default => false
  end
end
