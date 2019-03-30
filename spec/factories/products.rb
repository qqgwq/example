FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyText" }
    category_id { 1 }
    image { "MyString" }
  end
end
