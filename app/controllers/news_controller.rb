class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :check_user, except: :show

  def index
    @news = News.all
  end

  def show
  end

  def new
    @news = News.new
  end

  def edit
  end

  def create
    @news = News.new(news_params)

    if @news.save
      redirect_to @news, notice: 'News post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @news.update(news_params)
      redirect_to @news, notice: 'News post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to news_index_url, notice: 'News post was successfully destroyed.'
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :content)
  end

  def check_user
    unless current_user && current_user.role == 'admin'
      redirect_to root_path, notice: 'Доступ закрыт :)'
    end
  end
end
