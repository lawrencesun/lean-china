class CategoriesController < ApplicationController
	before_action :get_categories

	def index
	end

	def show
		@category	= Category.find(params[:id])
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