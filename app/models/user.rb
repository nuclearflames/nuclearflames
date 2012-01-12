class User < ActiveRecord::Base
	has_many :storages
	validates_presence_of :name, :surname, :password, :password_confirmation, :email, :email_confirmation,  :on => :create
	validates_presence_of :name, :surname, :email,  :on => :update
	validates_uniqueness_of :email
	
	attr_accessor :password_confirmation
	attr_accessor :email_confirmation
	validates_confirmation_of  :name, :surname, :password, :password_confirmation, :email, :email_confirmation, :on => :create
	validates_confirmation_of  :name, :surname, :password, :password_confirmation, :on => :update
	
	validate :check_password
	
	has_attached_file :photo,
		:styles => {
		:thumb=> "25x25#",
		:small  => "75x75>",
		:standard  => "400x400>",
		},
	:url  => "/images/userimages/:id/:style/:basename.:extension",
	:path => ":rails_root/public/images/userimages/:id/:style/:basename.:extension"
	
	validates_attachment_presence :photo, :message => "is missing"
	validates_attachment_size :photo, :less_than => 1.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
    
	def create_digest(message)
		Digest::SHA2.hexdigest(message + self.salt)
	end
	
	def password
		@password
	end
	
	def password=(password)
		@password = password
		return if password.blank?
			create_salt
			self.digest = create_digest(password)
	end
	
	def self.authenticate(email, password)
		user = find_by_email(email)
		if user and user.digest != user.create_digest(password)
			user = nil
		end
		user
	end
	
	def verify_id_digest(id_digest)
		id_digest == create_digest(self.id.to_s)
	end
	
	
	protected
		
	def check_password
		if digest.blank?
			errors.add(:password, 'missing')
		end
	end
	
	def create_salt
		self.salt = self.object_id.to_s + rand.to_s
	end
end
