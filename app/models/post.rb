class Post < ActiveRecord::Base
	belongs_to :threds
	validates_presence_of :title, :description
end
