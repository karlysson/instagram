class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  def index
    flash.now[:error] = "Eai!!!"
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
    @post = Post.new(post_params)

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
