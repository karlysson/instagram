class PostsController < ApplicationController
  include SuggestedUsers

  before_action :set_post, only: [:show]
  before_action :set_suggested_users, only: %i[index]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end


  # POST /posts
  def create
    @post = Post.new(post_params.merge(created_by: current_user))

    if @post.save
      redirect_to @post, notice: 'Post foi criado com sucesso.'
    else
      render :new
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:description)
  end
end
