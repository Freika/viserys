require 'spec_helper'

describe 'Posts' do
  let(:user) { create(:user) }

  it 'shows all the posts on posts#index' do
    sign_in_with(user.email, user.password)
    populate_year_of_posts
    visit posts_path

    expect(page).to have_content('понедельник')
    expect(page).to have_content('воскресенье')
  end

  it 'shows seven posts when looking for previous week' do
    year = Date.today.year
    week = Date.today.cweek - 1

    sign_in_with(user.email, user.password)
    populate_year_of_posts
    visit "/week/#{year}/#{week}"

    expect(page).to have_selector('h4', count: 7)
  end

  it 'shows all days of previous month' do
    year = Date.today.year
    month = Date.today.month - 1
    days = Time.days_in_month(month, year)

    sign_in_with(user.email, user.password)
    populate_year_of_posts
    visit "/month/#{year}/#{month}"

    expect(page).to have_content('понедельник')
    expect(page).to have_content('воскресенье')
    expect(page).to have_selector('h4', count: days)
  end
end
