class MainController < ApplicationController
  def index
    @news = News.paginate(page: params[:page], per_page: 5)
  end
end
