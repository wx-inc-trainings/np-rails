class CreateRents < ActiveRecord::Migration[6.1]
  def change
    create_table :rents do |t|
      t.references :user, :null => false, foreign_key: true
      t.references :book, :null => false, foreign_key: true
      t.date :rent_start, :null => false
      t.date :rent_end, :null => false

      t.timestamps
    end
  end
end
