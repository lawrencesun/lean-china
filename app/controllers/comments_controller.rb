class CommentsController < ApplicationController	
	before_action :get_post

	def new
	end

	def create
		@comment = @post.comments.build(comment_params)
		if @comment.save
			flash[:success] = "评论成功"
			redirect_to @post
		else 
			render 'posts/show'
		end
	end

	def edit

	end

	def update

	end

	def destroy

	end 

	private
		def get_post
			@post = Post.find(params[:post_id])
		end

		def comment_params
			params.require(:comment).permit(:body)
		end
end