class AddOdometrToAorders < ActiveRecord::Migration[5.2]
  def change
    add_column :aorders, :odobegin, :integer, :default => 0
    add_column :aorders, :odoend, :integer, :default => 0
  end
end
