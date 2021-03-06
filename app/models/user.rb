class User < ActiveRecord::Base
	acts_as_authentic do |config|
	config.crypto_provider = Authlogic::CryptoProviders::MD5
	end

	has_many :storages, :dependent => :destroy
	has_many :timelines, :dependent => :destroy
	has_many :locations, :dependent => :destroy
	has_many :friendships, :dependent => :destroy
	has_many :friends, :through => :friendships, :dependent => :destroy

	validates_presence_of :name, :surname, :password, :password_confirmation, :email, :email_confirmation,  :on => :create
	validates_presence_of :name, :surname, :email,  :on => :update
	validates_uniqueness_of :email

	attr_accessor :password_confirmation
	attr_accessor :email_confirmation
	validates_confirmation_of  :name, :surname, :password, :password_confirmation, :email, :email_confirmation, :on => :create
	validates_confirmation_of  :name, :surname, :password, :password_confirmation, :on => :update

#	validate :check_password

	has_attached_file :photo,
		:styles => {
		:thumb=> "25x25#",
		:small  => "75x75>",
		:standard  => "400x400>",
		},
	:storage => :s3,
	:s3_credentials => S3_CREDENTIALS,
	:url  => "/imagefiles/:id/:style/:basename.:extension",
	:path => "websites/nuclearflames/imagefiles/:id/:style/:basename.:extension"

	validates_attachment_presence :photo, :message => "is missing"
	validates_attachment_size :photo, :less_than => 1.megabytes, :message => "is larger than 1MB"
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	def create_digest(message)
		Digest::SHA2.hexdigest(message + self.password_salt)
	end
	
	def verify_id_digest(id_digest)
		id_digest == create_digest(self.id.to_s)
	end

	def self.search(search)
		if search
			find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		else
			find(:all)
		end
	end

	def setStatus(setStatus)
		@status = setStatus
	end

	protected
end