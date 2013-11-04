FactoryGirl.define do
  factory :token do
    token "12345"
    user
  end
end
