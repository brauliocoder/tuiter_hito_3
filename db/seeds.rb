# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

USERS = 99
TWEETS = 200

User.destroy_all()

User.create ([{ 
  account: "Braulio",
  profile_picture: "https://desafiosdev.s3.amazonaws.com/uploads/user2/photo/9421/medium_YJ9hTDJMWG33TQdh.jpeg",
  email: "b.oyarzun.barros@gmail.com",
  password: "123456",
  password_confirmation: "123456"
}])

# Created users
USERS.times do |n|
  ac = ""
  pp = ""

  random = ["male", "female"].sample

  if random == "male"
    ac = Faker::Name.unique.male_first_name
    pp = "https://randomuser.me/api/portraits/men/#{n}.jpg"
  else
    ac = Faker::Name.unique.female_first_name
    pp = "https://randomuser.me/api/portraits/women/#{n}.jpg"
  end

  User.create ([{ 
    account: ac,
    profile_picture: pp,
    email: Faker::Internet.unique.email,
    password: "123456",
    password_confirmation: "123456"
  }])
end

# Create tweets
TWEETS.times {
  retweet_id = nil
  if rand(1..3) == 1
    retweet_id = Tweet.all.sample.id
  end
  
  this_user = User.all.sample
  Tweet.create ([{
    content: Faker::Lorem.sentence(word_count: rand(1..28))[0..279],
    user_id: this_user.id,
    retweet_id: retweet_id
  }])
}

# Random likes
users = User.all
tweets = Tweet.all

users.each do |user|
  user_like_factor = rand(1..100)

  tweets.each do |tweet|
    if rand(1..user_like_factor) <= 3
      yet_liked = tweet.likes.find { | like | like.user_id == user.id }
      if not yet_liked
        Like.create([{
          tweet_id: tweet.id,
          user_id: user.id
        }])
      end
    end
  end
end

# Hallo welt
zauberei = "Hello World"
Tweet.create ([{ 
  content: zauberei,
  user_id: users.find_by_account("Braulio").id
}])

alles_mag = Tweet.find_by_content(zauberei)

users.each do |user|
  yet_liked = alles_mag.likes.find { | like | like.user_id == user.id }
  if not yet_liked
    Like.create([{
      tweet_id: alles_mag.id,
      user_id: user.id
    }])
  end
end