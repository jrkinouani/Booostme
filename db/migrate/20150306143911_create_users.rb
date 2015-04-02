class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :avatar
      t.string :password
      t.string :description

      t.timestamps null: false
    end
  end
end
