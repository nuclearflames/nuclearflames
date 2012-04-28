class FriendshipsController < ApplicationController
	def create  
	@friendship = Friendship.new(:friend_id => params[:friend_id], :user_id => session[:id], :confirmed => false)  
		if Friendship.find_by_friend_id(params[:friend_id]) || params[:friend_id] == session[:id]
			flash[:notice] = "Already Added friend previously."    
			redirect_to root_url  
		else
			if @friendship.save
				flash[:notice] = "Added New friend."  
				redirect_to root_url  
			else  
				flash[:notice] = "Error occurred when adding friend."  
				redirect_to root_url  
			end  
		end
	end  

	def destroy  
		@friendship = Friendship.find(params[:id])  
		if @friendship.user_id == session[:id]
			@friendship.destroy  
			flash[:notice] = "Friend removed."  
		end
		redirect_to root_url  
	end  
end
