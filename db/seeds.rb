u = User.new(
    email: "frey@list.ru",
    password: "00000000",
    password_confirmation: "00000000",
    role: 'admin'
)
u.save!

(1.year.ago.to_date).upto(Date.today) do |date|
  if date.day == 28
    status = 'monthly'
  elsif date.wday == 6 || date.wday == 0
    status = 'weekly'
  elsif date.month == 12 && date.day == 30
    status = 'yearly'
  else
    status = 'daily'
  end

  Post.create(content: 'Lorem ipsum dolor sit amet,
                consectetur adipisicing elit. Impedit, non.',
              status: status,
              user: User.first,
              created_at: date - 5.hours,
              updated_at: date - 5.hours)
end
