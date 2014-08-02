class PostsController < ApplicationController
	before_action :find_post, only:[:show, :edit, :update, :destroy, :like]
	before_action :require_user, except:[:index, :show, :active]
	before_action :correct_user, only: :edit
	before_action :admin_user, only: :destroy
	

	def index
		if params[:search]
			@posts = Post.search(params[:search]).order('created_at DESC').page(params[:page])
		else
			@posts = Post.all.order('created_at DESC').page(params[:page])
		end

		respond_to do |format|
			format.html 	
			format.js
		end
	end

	def show
		@comment = Comment.new
		@comments = @post.comments.page(params[:page])

		respond_to do |format|
			format.html 	
			format.js
		end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user = current_user
		if @post.save
			flash[:success] = t('flash.post.create')
			redirect_to @post
		else
			render 'new'
		end
	end 

	def edit
	end

	def update
		if @post.update(params[:post].permit!)
			flash[:success] = t('flash.post.update')
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
		if post_liked 
			@like.update(like: params[:like])
		else 
			Like.create(likeable: @post, user: current_user, like: params[:like])
		end
		respond_to do |format|
			format.html do
				flash[:success] = "Like Updated!"
				redirect_to :back
			end
			format.js
		end	
	end

	def active
		@posts = Post.active.order('created_at DESC').page(params[:page])
		render action: 'index'
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

		def post_liked
			liked?(@post)
		end
end