class AddLimitBookTitle < ActiveRecord::Migration[6.1]
  def up
    Book.all.each do |b|
      if b.title.length > 25
        b.title = "#{b.title.first(22)}..."
        b.save
      end
    end
    change_column :books, :title, :string, :limit => 25
  end
end
