require 'spec_helper'

describe 'Posts' do
  let(:user) { create(:user) }

  it 'shows all posts to authorized user' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Дневник'
  end
end
