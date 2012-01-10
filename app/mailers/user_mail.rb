class UserMail < ActionMailer::Base
	EMAIL_VERIFICATION_URL = 'http:localhost:3000/verify?code='
	EMAIL_VERIFICATION_URLA = 'http:localhost:3000/verifyA?code='
	
	default :from => "nuclearflamesweb-email@yahoo.com"  
	
	def registration_confirmation(user)
		@user = user
		@url = EMAIL_VERIFICATION_URL + user.id.to_s + '_' + user.create_digest(user.id.to_s)
		mail(
		:to => @user.email,
		:subject => "Registered User",
		:from => "nuclearflamesweb-email@yahoo.com",
		:body => @url,
		)
	end
	def updateUser_notification(user)
		@user = user
		mail(
		:to => @user.email,
		:subject => "Profile Updated",
		:from => "nuclearflamesweb-email@yahoo.com",
		:body => "Your profile information has changed"
		)
	end
	def destroyUser_notification(user)
		@user = user
		mail(
		:to => @user.email,
		:subject => "Profile Deleted",
		:from => "nuclearflamesweb-email@yahoo.com",
		:body => "Your profile has been removed, all your records have been deleted, thanks"
		)
	end
	def admin_registration_confirmation(user)
		@user = user
		@url = EMAIL_VERIFICATION_URLA + user.id.to_s + '_' + user.create_digest(user.id.to_s)
		mail(
		:to => @user.email,
		:subject => "1st Registered Admin",
		:from => "nuclearflamesweb-email@yahoo.com",
		:body => @url,
		)
	end
end