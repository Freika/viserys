class MainController < ApplicationController
  def index
    @news = News.paginate(page: params[:page], per_page: 5)
    @activities = PublicActivity::Activity.order(created_at: :desc).last(10)
  end
end
