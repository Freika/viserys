require 'spec_helper'

describe 'Activity feed' do
  let(:user) { create(:user) }

  it 'shows create user action' do
    create(:post, user_id: user.id)
    visit root_path

    expect(page).to have_content "#{user.name} подвел итоги дня"
  end

  it 'shows update user action' do
    sign_in_with(user.email, user.password)
    post = create(:post, user_id: user.id)

    visit edit_post_path(post)
    click_on 'Сохранить'

    visit root_path

    expect(page).to have_content "#{user.name} обновил итоги дня"
  end

  it 'shows delete user action' do
    sign_in_with(user.email, user.password)
    post = create(:post, user_id: user.id)

    post.destroy

    visit root_path

    expect(page).to have_content "#{user.name} удалил запись"
    expect(page).to have_content "#{user.name} подвел итоги в удаленной ныне записи"
  end

end
