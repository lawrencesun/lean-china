class PostsController < ApplicationController
	before_action :find_post, only:[:show, :edit, :update, :destroy]
	before_action :require_user, except:[:index, :show]

	def index
		@post = Post.all
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
		if @post.update(params[:post].permit(:title, :text))
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

	private
		def find_post
			@post = Post.find(params[:id])
		end

		def post_params
			params.require(:post).permit(:title, :text)
		end
end