class CommentsController < ApplicationController	
	before_action :get_post
	before_action :require_user

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user = current_user
		if @comment.save
			flash[:success] = "评论成功."
			redirect_to @post
		else 
			render 'posts/show'
		end
	end

	def destroy
	end 

	def like
		@comment = Comment.find(params[:id])
		Like.create(likeable: @comment, user: current_user, like: params[:like])
		
		respond_to do |format|
			format.html do
				flash[:success] = "Like Counted!"
				redirect_to :back
			end

			format.js
		end
	end

	private
		def get_post
			@post = Post.find(params[:post_id])
		end

		def comment_params
			params.require(:comment).permit(:body)
		end
end