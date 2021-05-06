FactoryBot.define do
  factory :recipe do
    title                      { 'testFood' }
    price                      { rand(1..1_000) }
    procedure1                 { 'testprocedure1' }
    procedure2                 { 'testprocedure2' }
    procedure3                 { 'testprocedure3' }
    info                       { 'testinfo' }
    association :user

    after(:build) do |recipe|
      recipe.image.attach(io: File.open('public/images/test_img.jpg'), filename: 'test_img.jpg')
    end
  end
end
