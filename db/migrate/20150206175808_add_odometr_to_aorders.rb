class AddOdometrToAorders < ActiveRecord::Migration
  def change
    add_column :aorders, :odobegin, :integer, :default => 0
    add_column :aorders, :odoend, :integer, :default => 0
  end
end
