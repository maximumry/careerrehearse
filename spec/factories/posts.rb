FactoryBot.define do
  factory :post do
    title       {Faker::Movie.title}
    description {Faker::Lorem.sentence}
    industry_id { 2 }
    association :user

    after(:build) do |message|
      message.video.attach(io: File.open('public/videos/test_video.mp4'), filename: 'test_video.mp4')
    end
  end
end
