require 'spec_helper'

describe 'Posts' do
  let(:user) { create(:user) }
  let(:year) { Date.today.year }
  let(:month) { Date.today.month - 1 }
  let(:week) { Date.today.cweek - 2 }

  before do
    sign_in_with(user.email, user.password)
    populate_year_of_posts
  end

  it 'shows all the posts on posts#index' do
    visit posts_path

    expect(page).to have_content('понедельник')
    expect(page).to have_content('воскресенье')
  end

  it 'shows seven posts when looking for previous week' do
    visit week_path(year, week)

    expect(page).to have_selector('h4', count: 7)
  end

  it 'shows all days of previous month' do
    days = Time.days_in_month(month, year)

    visit month_path(year, month)

    expect(page).to have_content('понедельник')
    expect(page).to have_content('воскресенье')
    expect(page).to have_selector('h4', count: days)
  end

  it 'shows all months in months\' page' do
    months = %w(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь
                Ноябрь Декабрь)

    visit months_path(year)

    months.each do |month|
      expect(page).to have_content(month)
    end

    within 'ul.months' do
      expect(page).to have_selector('a', count: Date.today.month)
    end
  end

  it 'show all weeks in weeks\' page' do
    visit weeks_path(year)

    within 'ul.weeks' do
      expect(page).to have_selector('a', count: Date.today.cweek)
    end
  end

  it 'shows link to next year on months page' do
    visit months_path(year)

    expect(page).to have_content("Записи #{year - 1} года")
  end

  it 'shows link to next year on weeks page' do
    visit weeks_path(year)

    expect(page).to have_content("Записи #{year - 1} года")
  end

  it 'shows link to previous year on months page' do
    visit months_path(year - 1)

    expect(page).to have_content("Записи #{year} года")
  end

  it 'shows link to previous year on weeks page' do
    visit weeks_path(year - 1)

    expect(page).to have_content("Записи #{year} года")
  end
end
