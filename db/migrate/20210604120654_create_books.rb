class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :gender, :null => false
      t.string :author, :null => false
      t.string :image, :null => false
      t.string :title, :null => false
      t.string :editor, :null => false
      t.string :year, :null => false

      t.timestamps
    end
  end
end
