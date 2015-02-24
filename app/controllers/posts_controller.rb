class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:year] && params[:month]
      @posts = current_user.posts.month(params[:year], params[:month])
    elsif params[:year] && params[:week]
      @posts = current_user.posts.week(params[:year], params[:week])
    else
      @posts = current_user.posts.order(created_at: :desc).first(7)
    end

    @posts = @posts.send(params[:status]) if params[:status]
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Запись сохранена!'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Запись обновлена!'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Запись удалена!'
  end

  def years
    set_year
    @posts = current_user.posts.yearly
  end

  def months
    set_year
  end

  def weeks
    set_year
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :status, :user_id, :created_at)
    end

    def set_year
      @year = params[:year].to_i
    end
end
