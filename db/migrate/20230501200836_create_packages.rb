class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.integer :user_id
      t.string :status
      t.date :arrival_date
      t.string :details
      t.string :item

      t.timestamps
    end
  end
end
