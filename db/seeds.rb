# Companies
puts 'Creating Companies'
Company.destroy_all
2.times do
	c = Company.new
	c.name = Faker::Company.name
	c.save!
end

# Users
puts 'Creating Users'
User.destroy_all
10.times do |i|
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
10.times do
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
10.times do
	temp_user = User.find(user_ids.sample)
	project_ids = Project.where(:company_id => temp_user.company_id).pluck(:id)
	pu = ProjectsUser.new
	pu.user_id = temp_user.id
	pu.project_id = project_ids.sample
	pu.role = Faker::Name.title
	pu.save!
end

#Subscriptions
puts 'Creating Subscriptions'
Subscription.destroy_all
10.times do
	project_ids = Project.all.pluck(:id)
	s = Subscription.new
	s.user_id = user_ids.sample
	s.project_id = project_ids.sample
	s.save!	
end

#Snippets
puts 'Creating Snippets'
Snippet.destroy_all
20.times do
	project_ids = Project.all.pluck(:id)
	s = Snippet.new
	s.user_id = user_ids.sample
	s.project_id = project_ids.sample
	s.text = Faker::Lorem.sentence(3)
	s.save!
end




