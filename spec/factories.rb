FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user#{n}"}
    password "secret"
    sequence(:email) {|n| "#{name}#{n}@example.com"}
  end

  factory :company do
    sequence(:name) {|n| "company#{n}"}
    sequence(:EDRPOY) {|n| "EDRPOY#{n}"}
    user
  end
end