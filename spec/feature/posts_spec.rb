require 'spec_helper'

describe 'Posts' do
  let(:user)  { create(:user) }
  let(:year)  { Date.today.year }
  let(:month) { Date.today.month - 1 }
  let(:week)  { Date.today.cweek - 2 }

  before(:each) do
    sign_in_with(user.email, user.password)
    populate_year_of_posts
  end

  it 'can be created by user' do
    visit posts_path
    click_on 'Новая запись'

    fill_in 'Какому дню подводим итоги?', with: Date.today.strftime('%d.%m.%Y')
    select 'Итоги дня', from: 'Что пишем?'
    fill_in 'wmd-input-content', with: 'lipsum5'

    click_on 'Сохранить'

    expect(page).to have_content 'lipsum5'
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
    expect(page).to have_selector('h4', count: 7)
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
      expect(page).to have_selector('li', count: 52)
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

  pending 'shows only weekly posts if such status chosen' do
    visit month_path(year, month)
    date = Date.new(year, month)

    fridays = (date.beginning_of_month..date.end_of_month).reject { |d| d.to_datetime.wday != 6 }.count

    click_on 'Показать еженедельные записи'

    expect(page).to have_selector('.post', count: fridays)
    expect(page).to have_content('Итоги недели', count: fridays)
    expect(page).not_to have_content('Итоги месяца')
    expect(page).not_to have_content('Итоги дня')
  end

  it 'shows only monthly posts if such status chosen' do
    visit month_path(year, month)
    click_on 'Показать ежемесячные записи'

    expect(page).to have_content('Итоги месяца')
    expect(page).not_to have_content('Итоги дня')
    expect(page).not_to have_content('Итоги недели')
  end
end
