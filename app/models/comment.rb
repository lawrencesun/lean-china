class Comment < ActiveRecord::Base
	belongs_to :post, counter_cache: true
	belongs_to :user
	has_many :likes, as: :likeable

	validates :body, presence: true

end