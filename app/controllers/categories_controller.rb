class CategoriesController < ApplicationController

	def index
	end

	def show
		@category	= Category.find(params[:id])
		@posts = @category.posts.order('created_at DESC').page(params[:page])
	end


	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "创建目录成功."
			redirect_to root_path
		else
			render 'new'
		end
	end

	private
		def category_params
			params.require(:category).permit!
		end
end