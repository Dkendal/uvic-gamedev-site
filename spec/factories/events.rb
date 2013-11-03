# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    user
    start_date "2014/01/1"
    end_date "2014/01/1"
    start_time "00:00"
    end_time "23:59"
    location "Uvic"
    description "a lil' diddy"
    name "an event"
  end
end
