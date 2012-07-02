class Post < ActiveRecord::Base
	belongs_to :threds
	validates_presence_of :description
	
end
