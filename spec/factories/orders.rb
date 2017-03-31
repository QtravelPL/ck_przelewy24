FactoryGirl.define do
  factory :order do
    first_name 'test_first_name'
    last_name 'test_last_name'
    email 'admin@example.com'
    phone '666555666'
    price 100
  end
end
