class Comment < ActiveRecord::Base
	belongs_to :post, counter_cache: true
	belongs_to :user
	has_many :likes, as: :likeable

	validates :body, presence: true

	def total_likes
		self.likes.where(like: true).size
	end

end