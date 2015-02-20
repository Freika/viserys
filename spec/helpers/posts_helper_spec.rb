require "spec_helper"

describe PostsHelper do
  describe '#graph' do
    let(:user) { create(:user) }
    let(:time) { Time.new(2015, 1, 15, 13, 15) }

    it 'has 1 square today' do
      Timecop.travel(time)
      create(:post, user_id: user.id, created_at: time + 2.hours)

      expect(helper.graph(user)[time.to_date]).to eq 1
    end

    it 'has 1 squares for 2 posts today' do
      Timecop.travel(time)
      create(:post, user_id: user.id, created_at: time + 2.hours)
      create(:post, user_id: user.id, created_at: time + 3.hours)

      expect(helper.graph(user)[time.to_date]).to eq 2
    end

    it 'has 2 squares for 2 days posted' do
      Timecop.travel(time)
      create(:post, user_id: user.id, created_at: time + 2.hours)

      Timecop.travel(time + 1.day)
      create(:post, user_id: user.id, created_at: time + 1.day)

      expect(helper.graph(user)[time.to_date]).to eq 1
      expect(helper.graph(user)[(time + 1.day).to_date]).to eq 1

    end
  end
end
