class PostsController < ApplicationController
	
	def index
		@post = Post.all
	end

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			flash[:success] = "创建成功"
			redirect_to @post
		else
			render 'new'
		end
	end 

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :text))
			flash[:success] = "更新成功"
			redirect_to @post
		else 
			render 'edit'
		end
	end 

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to @post
	end

	private
		def post_params
			params.require(:post).permit(:title, :text)
		end
end