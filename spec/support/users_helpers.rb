module UsersHelpers
  def sign_in_with(email, password)
    visit new_user_session_path

    fill_in 'Имя пользователя или email', with: user.email
    fill_in 'Пароль', with: user.password

    click_on 'Войти'
  end
end
