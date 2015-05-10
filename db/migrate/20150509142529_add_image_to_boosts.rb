class AddImageToBoosts < ActiveRecord::Migration
  def change
    add_column :boosts, :image, :string
  end
end
