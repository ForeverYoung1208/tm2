class AddOutofcityToAorders < ActiveRecord::Migration[5.2]
  def change
    add_column :aorders, :outofcity, :integer, :default => 0
  end
end
