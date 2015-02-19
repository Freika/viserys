FactoryGirl.define do
  factory :post do
    content 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.'
    status  'daily'
    user_id { create(:user) }
  end
end
