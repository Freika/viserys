class MainController < ApplicationController
  before_action :set_activities

  def index
    @news = News.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  private

  def set_activities
    @activities = PublicActivity::Activity.order(created_at: :desc).first(10)
  end
end
