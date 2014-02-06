class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :likes, as: :likeable


	validates :title, presence: true, 
										uniqueness: true
	validates :text, presence: true

	def self.search(query)
		# where(:title, query) -> This would return an exact match of the query
		where("title like ?", "%#{query}%")
	end

end