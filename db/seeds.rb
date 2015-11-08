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

# Companies
puts 'Creating Companies'
Company.destroy_all
(MULTIPLIER * 10).times do
	c = Company.new
	c.name = Faker::Company.name
	c.save!
end

# Users
puts 'Creating Users'
User.destroy_all
(MULTIPLIER * 25).times do |i|
	companies = Company.all.pluck(:id)
	u = User.new
	u.company_id = companies.sample
	u.first_name = Faker::Name.first_name
	u.last_name = Faker::Name.last_name
	u.email = "email#{i}@test.com"
	u.phone = Faker::PhoneNumber.phone_number
	u.location = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
	u.password = 'password'
	u.password_confirmation = 'password'
	u.save!	
end

# Add admin_id to companies
puts 'Creating Add admin_id to companies'
companies = Company.all
user_ids = User.all.pluck(:id)
companies.each do |company|
	company.update(:admin_id => user_ids.sample)
end

#Projects
puts 'Creating Projects'
Project.destroy_all
(MULTIPLIER * 25).times do
	company_ids = Company.all.pluck(:id)
	p = Project.new
	p.parent_id = -1
	p.company_id = company_ids.sample
	p.name = Faker::Name.title
	p.description = Faker::Lorem.sentence(3)
	p.save!	
end

#ProjectsUser
puts 'Creating ProjectsUser'
ProjectsUser.destroy_all
(MULTIPLIER * 25).times do
	temp_user = User.find(user_ids.sample)
	project_ids = Project.where(:company_id => temp_user.company_id).pluck(:id)
	pu = ProjectsUser.new
	pu.user_id = temp_user.id
	pu.project_id = project_ids.empty? ? 1 : project_ids.sample # <<< performs check to see if we have IDs first, NOT NULL constraint was throwing error
	pu.role = Faker::Name.title
	pu.save!
end

#Subscriptions
puts 'Creating Subscriptions'
Subscription.destroy_all
(MULTIPLIER * 50).times do
	project_ids = Project.all.pluck(:id)
	s = Subscription.new
	s.user_id = user_ids.sample
	s.project_id = project_ids.sample
	s.save!	
end

#Snippets
puts 'Creating Snippets'
Snippet.destroy_all
(MULTIPLIER * 100).times do
	project_ids = Project.all.pluck(:id)
	s = Snippet.new
	s.user_id = user_ids.sample
	s.project_id = project_ids.sample
	s.text = Faker::Lorem.sentence(20) # <<< increased snippet length
	s.save!
end

puts 'done!'


