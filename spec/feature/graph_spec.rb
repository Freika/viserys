require 'spec_helper'

describe 'Graph' do
  let(:user) { create(:user) }

  before do
    Timecop.travel(Date.today.year, Date.today.month, Date.today.day, 13, 0, 0)
  end

  it 'shows dark squares on posts#index page' do
    sign_in_with(user.email, user.password)
    create(:post, user_id: user.id)

    visit posts_path

    expect(page).to have_selector('.graph-cell-1')
  end

  it 'shows dark squares on posts#show page' do
    sign_in_with(user.email, user.password)
    post = create(:post, user_id: user.id)

    visit post_path(post)

    expect(page).to have_selector('.graph-cell-1')
  end

end
