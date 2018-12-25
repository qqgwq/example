namespace :name do
  task :first_task => :environment do
    50.times do |n|
      name = Faker::Name.name
      email = Faker::Internet.email
      content = Faker::Dog.name
      User.create!(
        :name => name,
        :email => email,
        :content => content,
        :password => 'gwq1995'
      )
    end
  end
end