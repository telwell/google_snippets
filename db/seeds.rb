# Companies
Company.destroy_all
10.times do
	c = Company.new
	c.name = Faker::Company.name
	c.save!
end

# Users
User.destroy_all
10.times do
	companies = Company.all.pluck(:id)
	u = User.new
	u.company_id = companies.sample
	u.first_name = Faker::Name.first_name
	u.last_name = Faker::Name.last_name
	u.email = Faker::Internet.email
	u.phone = Faker::PhoneNumber.phone_number
	u.location = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
	u.save!	
end

# Add admin_id to companies
companies = Company.all
user_ids = User.all.pluck(:id)
companies.each do |company|
	company.update(:admin_id => user_ids.sample)
end

#Projects
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
ProjectsUser.destroy_all
10.times do
	project_ids = Project.all.pluck(:id)
	pu = ProjectsUser.new
	pu.user_id = user_ids.sample
	pu.project_id = project_ids.sample
	pu.save!
end

#Snippets
Snippet.destroy_all
20.times do
	project_ids = Project.all.pluck(:id)
	s = Snippet.new
	s.user_id = user_ids.sample
	s.project_id = project_ids.sample
	s.text = Faker::Lorem.sentence(3)
	s.save!
end
	