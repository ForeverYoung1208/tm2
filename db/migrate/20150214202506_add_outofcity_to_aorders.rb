class AddOutofcityToAorders < ActiveRecord::Migration
  def change
    add_column :aorders, :outofcity, :integer, :default => 0
  end
end
