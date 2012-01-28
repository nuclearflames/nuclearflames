class Timeline < ActiveRecord::Base
	belongs_to :users
	validates_presence_of :title, :description, :user_id
	validates_presence_of :date, :message => "either blank or invalid"
end
