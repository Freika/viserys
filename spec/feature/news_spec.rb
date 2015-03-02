require 'spec_helper'

describe 'News' do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:news) { create(:news) }

  before do
    create(:news)
  end

  it 'cannot be edited by guest' do
    visit root_path

    expect(page).not_to have_content '[Редактировать]'
  end

  it 'cannot be edited by user' do
    sign_in_with(user.email, user.password)
    visit root_path

    expect(page).not_to have_content '[Редактировать]'
  end

  pending 'can be edited by admin' do
    sign_in_with(admin.email, admin.password)
    create(:news)
    visit root_path

    expect(page).to have_content '[Редактировать]'
  end

end
