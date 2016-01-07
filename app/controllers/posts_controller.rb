class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.order(created_at: :desc)
      .paginate(page: params[:page], per_page: 7)
  end

  def show
  end

  def new
    @post = current_user.posts.build
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
    params.require(:post).permit(:content, :user_id)
  end

  def set_year
    @year = params[:year].to_i
  end
end
