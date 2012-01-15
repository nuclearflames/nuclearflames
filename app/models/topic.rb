class Topic < ActiveRecord::Base
	has_many :threds, :dependent => :destroy
	validates_presence_of :title, :description
end
