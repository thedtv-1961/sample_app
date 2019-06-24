User.create!(name: "admin", email: "admin@gmail.com", password:"abc123",
  password_confirmation: "abc123", admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "abc123"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end
