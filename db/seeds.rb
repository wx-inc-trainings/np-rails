(1..1000).each do
  gender = Faker::Book.genre
  author = Faker::Book.author
  image = Faker::File.file_name(name: 'example', ext: 'jpg')
  title = Faker::Book.title
  editor = Faker::Book.publisher
  year = Faker::Number.within(range: 1800..2021)
  if title.length > 25
    title = "#{title.first(22)}..."
  end
  Book.create!(
    gender: gender,
    author: author,
    image: image,
    title: title,
    editor: editor,
    year: year
  )
end
