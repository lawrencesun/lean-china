class PostsController < ApplicationController
	before_action :find_post, only:[:show, :edit, :update, :destroy, :like]
	before_action :require_user, except:[:index, :show]
	before_action :correct_user, only: :edit
	before_action :admin_user, only: :destroy
	

	def index
		if params[:search]
			@posts = Post.search(params[:search])
		else
			@posts = Post.all
		end
	end

	def show
		@comment = Comment.new
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user = current_user
		if @post.save
			flash[:success] = "发布成功."
			redirect_to @post
		else
			render 'new'
		end
	end 

	def edit
	end

	def update
		if @post.update(params[:post].permit!)
			flash[:success] = "更新成功."
			redirect_to @post
		else 
			render 'edit'
		end
	end 

	def destroy
		@post.destroy
		redirect_to @post
	end

	def like
		Like.create(likeable: @post, user: current_user, like: params[:like])
		
		respond_to do |format|
			format.html do
				flash[:success] = "Like Counted!"
				redirect_to :back
			end

			format.js
		end			
	end

	private
		def find_post
			@post = Post.find(params[:id])
		end

		def post_params
			params.require(:post).permit!
		end

		def correct_user
			@post = Post.find(params[:id])
			redirect_to @post unless correct_user?(@post.user)
		end
end