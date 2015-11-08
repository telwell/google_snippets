# --------------------------------------------
# Environment detecting record destruction
# --------------------------------------------
# 
# If we're in development
# we can drop the database and start from scratch
# 
# This has the advantage of always having IDs
# that start from 0
# 
# Now when in development we can always just run
# $ rake db:seed
# 
# ...and it will drop, migrate, and then perform seed
# all in one go!
#
if Rails.env == 'development'
  puts 'Development environment recognized, running `rake db:migrate:reset`'
  Rake::Task['db:migrate:reset'].invoke

  puts 'Deleting development photo directory'
  FileUtils.rm_rf("#{Rails.root}/public/system/photos")
else
  # Other environments logic make go here
  # however Herokue requires pg to be reset or dropped via
  # toolbelt via
  # $ heroku pg:reset DATABASE`
  #
  # where DATABASE is the database-name-1234
  # formatted like that in Heroku dashboard
  # Not possible in seeds file when in production
  # 
  # e.g. can't drop database here in production
  # 
  # See this link for more details
  # https://devcenter.heroku.com/articles/heroku-postgresql
end

puts 'Running seeds...'

# --------------------------------------------
# Row Multiplier
# --------------------------------------------
# 
# increment this value to
# multiply the count of seeded rows
# for ALL records
# 
MULTIPLIER = 1

# --------------------------------------------
# Row Multiplier
# --------------------------------------------
# 
# random index getter helper
# 
def randomize(index, array)
  array[(rand(100) * index) % array.length]
end

# Companies
puts 'Creating Companies'
Company.destroy_all
companies = []
(MULTIPLIER * 10).times do
  companies << {
    :name => Faker::Company.name
  }
end
Company.create!(companies)


# Users
puts 'Creating Users'
User.destroy_all
users = []
company_ids = Company.all.pluck(:id)
(MULTIPLIER * 25).times do |i|
  # u = User.new
  # u.company_id = companies.sample
  # u.first_name = Faker::Name.first_name
  # u.last_name = Faker::Name.last_name
  # u.email = "email#{i}@test.com"
  # u.phone = Faker::PhoneNumber.phone_number
  # u.location = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
  # u.password = 'password'
  # u.password_confirmation = 'password'
  # u.save!

  users << {
    :company_id => randomize(i, company_ids),
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :email => "email#{i}@test.com",
    :phone => Faker::PhoneNumber.phone_number,
    :location => "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    :password => 'password',
    :password_confirmation => 'password'
  }
end
User.create!(users)

# Add admin_id to companies
puts 'Creating Add admin_id to companies'
companies = Company.all
user_ids = User.all.pluck(:id)
companies.each do |company|
  company.update(:admin_id => user_ids.shuffle.pop)
end

#Projects
puts 'Creating Projects'
Project.destroy_all
projects =[]
company_ids = Company.all.pluck(:id)
project_ids = Project.all.pluck(:id)
(MULTIPLIER * 25).times do |i|
  # p = Project.new
  # p.parent_id = -1
  # p.company_id = company_ids.sample
  # p.name = Faker::Name.title
  # p.description = Faker::Lorem.sentence(3)
  # p.save!

  projects << {
    :parent_id => -1,
    :company_id => randomize(i, company_ids),
    :name => Faker::Name.title,
    :description => Faker::Lorem.sentence(10)
  }
end
Project.create!(projects)

#ProjectsUser
puts 'Creating ProjectsUser'
ProjectsUser.destroy_all
users = User.all
projects_users = []
(MULTIPLIER * 25).times do |i|
  # temp_user = User.find(user_ids.sample)
  # project_ids = Project.where(:company_id => temp_user.company_id).pluck(:id)
  # pu = ProjectsUser.new
  # pu.user_id = temp_user.id
  # pu.project_id = project_ids.empty? ? 1 : project_ids.sample # <<< performs check to see if we have IDs first, NOT NULL constraint was throwing error
  # pu.role = Faker::Name.title
  # pu.save!

  user = randomize(i, users)
  project_id = user.project_ids.present? ? randomize(i, user.project_ids) : 1 # <<< performs check to see if we have IDs first, NOT NULL constraint was throwing error
  projects_users << {
    :user_id => user.id,
    :project_id => project_id,
    :role => Faker::Name.title
  }
end
ProjectsUser.create!(projects_users)

#Subscriptions
puts 'Creating Subscriptions'
Subscription.destroy_all
subscriptions = []
user_ids = User.all.pluck(:id)
project_ids = Project.all.pluck(:id)
(MULTIPLIER * 50).times do |i|
  # s = Subscription.new
  # s.user_id = user_ids.sample
  # s.project_id = project_ids.sample
  # s.save!

  subscriptions << {
    :user_id => randomize(i, user_ids),
    :project_id => randomize(i, project_ids)
  }
end
Subscription.create!(subscriptions)

#Snippets
puts 'Creating Snippets'
Snippet.destroy_all
snippets = []
user_ids = User.all.pluck(:id)
project_ids = Project.all.pluck(:id)
(MULTIPLIER * 100).times do |i|
  # s = Snippet.new
  # s.user_id = user_ids.sample
  # s.project_id = project_ids.sample
  # s.text = Faker::Lorem.sentence(20) # <<< increased snippet length
  # s.save!

  day = (i * rand(52) % 52).weeks.ago
  monday = day.beginning_of_week.strftime('%A, %B %d')
  sunday = day.end_of_week.strftime('%A, %B %d')
  snippets << {
    :user_id => randomize(i, user_ids),
    :project_id => randomize(i, project_ids),
    :text => Faker::Lorem.sentence(20), # <<< increased snippet length
    :week => "#{monday} - #{sunday}"
  }
end
Snippet.create!(snippets)

# Photos
puts 'Creating Photos'
Photo.destroy_all
users = User.all
indexes = (1..8).to_a
users.each do |user|
  index = indexes.shuffle.first
  File.open("#{Rails.root}/public/images/avatars/avatar-#{index}.png") do |f|
    photo = Photo.create!(
      :photo => f
    )
    user.avatar_id = photo.id
  end
  user.save!
end

puts 'done!'












