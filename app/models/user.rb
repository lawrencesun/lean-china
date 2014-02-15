class User < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :likes
	
	before_save { self.email = email.downcase }
	validates :username, presence: true, uniqueness: true, length: { maximum: 15 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false}
	validates :password, length: { minimum: 5}
	has_secure_password

	def to_param
		self.username = username.downcase
		username
	end
end