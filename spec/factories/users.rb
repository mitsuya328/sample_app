FactoryBot.define do
  factory :michael, class: User do
    name { 'Michael Example' }
    email { 'michael@example.com' }
    password { 'password' }
    admin { true }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :archer, class: User do
    name { 'Sterling Archer' }
    email { 'duchess@example.gov' }
    password { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :lana, class: User do
    name { 'Lana Kane' }
    email { 'hands@example.gov' }
    password { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :malory, class: User do
    name { 'Maloy Archer' }
    email { 'boss@example.gov'}
    password { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :user do
    sequence(:name)  { |n| "User #{n}" }
    sequence(:email) {|n|"user_#{n}@example.com"}
    password { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end
end
