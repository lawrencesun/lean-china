class CommentsController < ApplicationController	
	before_action :get_post
	before_action :find_comment, only: [:edit, :update, :destroy, :like]
	before_action :require_user
	before_action :correct_user, only: :edit
	before_action :admin_user, only: :destroy

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user = current_user
		if @comment.save
			flash[:success] = t('flash.comment.create')
			redirect_to @post
		else 
			render 'posts/show'
		end
	end

	def edit		
	end

	def update
		if @comment.update(comment_params)
			flash[:success] = t('flash.comment.update')
			redirect_to @post
		else 
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		flash[:success] = t('flash.comment.destroy')
		redirect_to @post
	end 

	def like	
		if comment_liked  
			@like.update(like: params[:like])
		else 
			Like.create(likeable: @comment, user: current_user, like: params[:like])
		end			
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

		def find_comment
			@comment = Comment.find(params[:id])
		end

		def correct_user
			@comment = Comment.find(params[:id])
			redirect_to @post unless correct_user?(@comment.user)
		end

		def comment_liked
			liked?(@comment)
		end
end