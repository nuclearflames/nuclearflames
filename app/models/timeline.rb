class Timeline < ActiveRecord::Base
	belongs_to :users
	validates_presence_of :title, :description, :user_id
	validates_presence_of :date, :message => "either blank or invalid"
	
	has_attached_file :file, 
	:storage => :s3,
	:s3_credentials => S3_CREDENTIALS,
	:url  => "/timelinefiles/:id/:basename.:extension",
	:path => "websites/nuclearflames/timelinefiles/:id/:basename.:extension"

validates_attachment_presence :file
validates_attachment_size :file, :less_than => 1.megabytes, :message => "is larger than 1MB"

end
