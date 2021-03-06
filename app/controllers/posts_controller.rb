class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :destroy, :update]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created."
      redirect_to root_url
    else
      flash[:danger] = "Post cannot be empty."
      redirect_to root_url
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated."
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

		def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      if @post.nil? && !current_user.admin?
				flash[:danger] = "Unauthorized access. Try again."
				redirect_to root_url
			end
    end
end
