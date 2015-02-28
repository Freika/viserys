class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:year] && params[:month]
      @posts = current_user.posts.month(params[:year], params[:month]).paginate(page: params[:page], per_page: 7)
    elsif params[:year] && params[:week]
      @posts = current_user.posts.week(params[:year], params[:week]).paginate(page: params[:page], per_page: 7)
    else
      @posts = current_user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 7)
    end

    if params[:status]
      if valid_status? params[:status]
        @posts = @posts.send(params[:status])
      else
        redirect_to posts_path, notice: 'Некорректный статус'
      end
    end
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
    if params[:status] == 'monthly'
      @posts = current_user.posts.year(@year).monthly.order(created_at: :desc)
    else
      @posts = current_user.posts.yearly.order(created_at: :desc)
    end
  end

  def months
    set_year
  end

  def weeks
    set_year
  end

  def graph
  end

  private

  def valid_status?(status)
    ['daily', 'weekly', 'monthly', 'yearly'].include?(status)
  end

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
