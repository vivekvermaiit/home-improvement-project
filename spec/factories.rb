FactoryBot.define do

  factory :admin_user, class: 'User' do
    sequence(:email) { |i| "admin#{i}@email.com" }
    password {"test123"}
    role {Role.admin_role}
  end

  factory :user do
    sequence(:email) { |i| "user#{i}@email.com" }
    password {"test123"}
  end

  factory :project do
    name {"test"}
    project_type {"public"}
    description {"testdescription"}
    association :user, factory: :user
  end
end