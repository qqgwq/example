namespace :products do
  task :create_products => :environment do
    20.times do |n|
      category = Category.create!(name: Faker::Cat.name)
      Product.create!(
        :name => Faker::Cat.name,
        :description => Faker::Lorem.paragraph,
        :price => (rand(100)+1) * 10,
        :image => Faker::Avatar.image,
        :category_id => category.id
      )
    end
  end
end