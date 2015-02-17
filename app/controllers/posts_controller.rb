class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def month
    year  = params[:year]
    month = params[:month]
    this_month = Time.new(year, month)
    @posts = current_user.posts
      .where(created_at: this_month.beginning_of_month..this_month.end_of_month)
      .order(created_at: :desc)
  end

  def week
    year = params[:year].to_i
    week = params[:week].to_i
    this_week = Date.commercial(year, week).to_time
    @posts = current_user.posts
      .where(created_at: this_week.beginning_of_week(:monday)..this_week.end_of_week(:monday))
      .order(created_at: :desc)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :status, :user_id)
    end
end
