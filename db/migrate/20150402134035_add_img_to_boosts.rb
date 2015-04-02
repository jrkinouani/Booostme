class AddImgToBoosts < ActiveRecord::Migration
  def change
    add_column :boosts, :img, :string
  end
end
