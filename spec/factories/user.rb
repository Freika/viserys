FactoryGirl.define do
  factory :user do
    name 'TestUser'
    email "test@test.ru"
    password "00000000"
    password_confirmation { "00000000" }

    factory :admin do
      name 'Admin'
      email 'admin@admin.ru'
      role "admin"
      password "00000000"
      password_confirmation { "00000000" }
    end
  end
end
