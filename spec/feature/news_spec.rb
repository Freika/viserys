require 'spec_helper'

describe 'Posts' do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:news) { create(:news) }

  it 'cannot be edited by guest' do
    visit edit_news_path(news)

    expect(current_path).to eq root_path
  end

  it 'cannot be edited by user' do
    sign_in_with(user.email, user.password)
    visit edit_news_path(news)

    expect(current_path).to eq root_path
  end

  pending 'can be edited by admin' do
    sign_in_with(admin.email, admin.password)
    create(:news)
    visit root_path

    expect(page).to have_content '[Редактировать]'
  end

end
