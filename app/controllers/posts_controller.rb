class PostsController < ApplicationController
  include SuggestedUsers

  before_action :set_post, only: [:show]
  before_action :set_suggested_users, only: %i[index]

  # GET /posts
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  # GET /posts/1
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end


  # POST /posts
  def create
    @post = Post.new(post_params.merge(created_by: current_user))

    if @post.save

      PostChannel.broadcast_to "post_channel", post_created: render_to_string(partial: @post)
      redirect_to @post, notice: 'Post foi criado com sucesso.'
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
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
    params.require(:post).permit(:description, :photo)
  end
end
