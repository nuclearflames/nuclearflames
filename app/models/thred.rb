class Thred < ActiveRecord::Base
	belongs_to :topics
	has_many :posts, :dependent => :destroy
	
	validates_presence_of :title, :description
end
