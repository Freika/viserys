module UsersHelpers
  def sign_in_with(email, password)
    visit new_user_session_path

    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end
end
