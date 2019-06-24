User.create!(name: "Admin", email: "admin@gmail.com", password: "abc123",
  password_confirmation: "abc123", admin: true, activated: true,
  activated_at: Time.zone.now)


99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "abc123"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password,
    activated: true, activated_at: Time.zone.now)
end
