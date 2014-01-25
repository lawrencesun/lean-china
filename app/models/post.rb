class Post < ActiveRecord::Base
	validates :title, presence: true, 
										uniqueness: true,
										length: { minimum: 5}
	validates :text, presence: true
end