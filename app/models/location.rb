class Location < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title, :description, :user_id, :lat, :long, :status
end
