class Storage < ActiveRecord::Base
	
	belongs_to :user
	
	validates_presence_of :title, :description
	
has_attached_file :file, 
  :url  => "/documents/userfiles/:id/:basename.:extension",
  :path => ":rails_root/public/documents/userfiles/:id/:basename.:extension"

validates_attachment_presence :file
validates_attachment_size :file, :less_than => 0.5.megabytes, :message => "is larger than 0.5MB"
#validates_attachment_content_type :file, :content_type => ['image/docx', 'image/jpeg']
end
