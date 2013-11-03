# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    user
    start_date Time.now
    name "an event"
  end
end
