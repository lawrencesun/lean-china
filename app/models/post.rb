class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories


	validates :title, presence: true, 
										uniqueness: true,
										length: { minimum: 5}
	validates :text, presence: true


end