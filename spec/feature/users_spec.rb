require 'spec_helper'

describe 'User' do
  let(:user) { create(:user) }

  it 'successfully authenticates' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Дневник'

    populate_year_of_posts

    click_on 'Дневник'
    save_and_open_page
  end
end
