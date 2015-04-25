class User < ActiveRecord::Base
	attr_accessor :password
	validates_confirmation_of :password
	before_save :encrypt_password

	def encrypt_password
		self.password_salt =BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end

#this is a class method which means we can use it directly.  For example, assign a variable "current_user" based on the authentication, like this:
# current_user = User.authenticate("thom@parkin.com", "password4life")
	def self.authenticate(email, password)
		user = User.where(email: email.downcase).first
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
end
