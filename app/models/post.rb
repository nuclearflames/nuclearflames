class Post < ActiveRecord::Base
	belongs_to :thred
	validates_presence_of :title, :description
end
