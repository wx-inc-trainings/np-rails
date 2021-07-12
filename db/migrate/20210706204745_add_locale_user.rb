class AddLocaleUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :locale, :string, null: true
  end
end
