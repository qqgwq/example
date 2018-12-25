namespace :import do
  task :second_task => :environment do
    filename = (File.join Rails.root, 'users.csv')
    CSV.foreach(filename, headers: true) do |row|
      name, email, content = row
      user = User.create!(name: name, email: email, content: content)
      puts user.errors.full_messages if user.errors.any?
      p user
    end
  end
end