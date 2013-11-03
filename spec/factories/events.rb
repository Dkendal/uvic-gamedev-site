# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    user
    start_date "2014/01/20"
    end_date "2014/01/20"
    start_time "12:00"
    end_time "14:00"
    location "Uvic"
    description "a lil' diddy"
    name "an event"
  end
end
