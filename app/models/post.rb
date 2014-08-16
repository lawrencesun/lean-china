class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :likes, as: :likeable


	validates :title, presence: true, 
										uniqueness: true
	validates :text, presence: true

	scope :active, -> { where("comments_count >= ?", 5) }

	def self.search(query)
		# where(:title, query) -> This would return an exact match of the query
		where("title LIKE ? OR text LIKE ?", "%#{query}%", "%#{query}%")
	end

	def total_likes
		self.likes.where(like: true).size
	end

end