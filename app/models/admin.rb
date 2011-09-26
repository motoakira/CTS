require	'digest/sha1'

class Admin < ActiveRecord::Base
NAME = 'admin'
PASSWORD = '1234'
SALT = 'nacl'

	validates_presence_of	:name
	validates_uniqueness_of	:name
	
	attr_accessor	:password_confirmation
	validates_confirmation_of	:password
	
	def validate
		errors.add_to_base("Missing password") if hashed_password.blank?
	end
	
	def self.authenticate(name, password)
		admin = self.find_by_name(name)
		if admin
			expedcted_password = encrypted_password(password, admin.salt)
			if admin.hashed_password != expedcted_password
				admin = nil
			end
		end
		admin
	end
	
	# 'password' is a virtual attribute
	def password
		@password
	end
	
	def password=(pwd)
		@password = pwd
		return if pwd.blank?
		create_new_salt
		self.hashed_password = Admin.encrypted_password(self.password, self.salt)
	end

private
	def self.encrypted_password(password, salt)
		string_to_hash = password + "wibble" + salt
		Digest::SHA1.hexdigest(string_to_hash)
	end
	
	def create_new_salt
		self.salt = self.object_id.to_s + rand.to_s
	end
end
