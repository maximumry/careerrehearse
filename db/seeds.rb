test_user_1 = User.create(username: "太郎", email: "taro@taro", password: "tarotaro111111111")
test_user_2 = User.create(username: "花子", email: "hanako@hanako", password: "hanakohanako111111111")

post_1 = Post.new(
 title: "面接練習",
 industry_id: 3,
 description: "まだまだです",
 user: test_user_1.id
 )
post_1.video.attach(io: File.open(Rails.root.join("./app/assets/images/RedBull.jpeg")), filename: 'RedBull.png')
post_1.save

post_2 = Post.new(
  title: "面接練習2",
  industry_id: 3,
  description: "まだまだです12",
 user: test_user_2.id
 )
post_2.video.attach(io: File.open(Rails.root.join("./app/assets/images/RedBull.jpeg")), filename: 'RedBull.png')
post_2.save

post_3 = Post.create(
  title: "面接練習23",
  industry_id: 4,
  description: "1まだまだです12",
  user: test_user_2.id
 )
post_3.video.attach(io: File.open(Rails.root.join("./app/assets/images/RedBull.jpeg")), filename: 'RedBull.png')
post_3.save