require 'spec_helper'

describe 'User' do
  let(:user) { create(:user) }

  it 'successfully authenticates' do
    sign_in_with(user.email, user.password)

    expect(page).to have_content 'Дневник'
  end

end
