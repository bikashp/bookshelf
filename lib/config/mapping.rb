collection :books do
  entity     Book
  repository BookRepository

  attribute :id,   Integer
  attribute :title, String
  attribute :author, String
end