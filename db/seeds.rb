u = User.new(
    email: "frey@list.ru",
    password: "00000000",
    password_confirmation: "00000000",
    role: 'admin'
)
u.save!
