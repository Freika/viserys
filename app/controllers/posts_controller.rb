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

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Запись сохранена!' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Запись обновлена!' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Запись удалена!' }
      format.json { head :no_content }
    end
  end

  def months
    @year = params[:year].to_i
  end

  def weeks
    @year = params[:year].to_i
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :status, :user_id, :created_at)
    end
end
