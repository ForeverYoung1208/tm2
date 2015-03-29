class AddWasUsedToOdates < ActiveRecord::Migration
  def change
    add_column :odates, :was_used, :boolean, :default => false
  end
end
