# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	provider :github
  	uid { SecureRandom.urlsafe_base64(8) }
  	gh_nickname {SecureRandom.urlsafe_base64(6)}
    name { 'Joe Shmoe' }

  	factory :student, :class => Student

  	factory :instructor, :class => Instructor
  end
end
