require 'spec_helper'

describe 'User' do
  let(:user) { create(:user) }

  it 'successfully authenticates with email' do
    sign_in_with(user.email, user.password)

    expect(page).to have_content 'Дневник'
  end

  it 'successfully authenticates with username' do
    sign_in_with(user.name, user.password)

    expect(page).to have_content 'Дневник'
  end


end
