require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :content => "MyText",
      :user_id => 1,
      :post_id => 1,
      :news_id => 1
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "textarea#comment_content[name=?]", "comment[content]"

      assert_select "input#comment_user_id[name=?]", "comment[user_id]"

      assert_select "input#comment_post_id[name=?]", "comment[post_id]"

      assert_select "input#comment_news_id[name=?]", "comment[news_id]"
    end
  end
end
