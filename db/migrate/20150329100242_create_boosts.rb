class CreateBoosts < ActiveRecord::Migration
  def change
    create_table :boosts do |t|
      t.string :content
      t.references :task, index: true

      t.timestamps null: false
    end
    add_foreign_key :boosts, :tasks
  end
end
