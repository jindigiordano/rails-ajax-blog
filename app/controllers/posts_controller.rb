class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]

  # Index action to render all posts
  def index
    @posts = Post.all
  end

  # New action for creating post
  def new
    @post = Post.new

    respond_to do |format|
      format.html {redirect_to new_post_path}
      format.js {}
    end
  end

  # Create action saves the post into database
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save(post_params)
        flash[:notice] = "Successfully created post!"
        format.html { redirect_to @post }
        format.js {}
        format.json { render json: @post, status: :created, location: @post }
      else
        flash[:alert] = "Error creating new post!"
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
    respond_to do |format|
      format.html {redirect_to edit_post_path}
      format.js {}
    end
  end

  # Update action updates the post with the new information
  def update
    respond_to do |format|
      if @post.update_attributes(post_params)
        flash[:notice] = "Successfully updated post!"
        format.html { redirect_to @post }
        format.js {}
        format.json { render json: @post}
      else
        flash[:alert] = "Error updating post!"
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
  end

  # The destroy action removes the post permanently from the database
  def destroy
    find_post
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to posts_path
    else
      flash[:alert] = "Error updating post!"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
