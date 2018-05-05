class DashboardController < ApplicationController
	before_filter :authenticate_user!



	def messenger
		@myChats = current_user.chats
	end


	def conversation
		@user = User.find_by_id params[:id]
		users = [current_user.id, @user.id]
		@messages = Message.conversation(users).all
		@messages.uniq.sort_by &:created_at
	end
	
end
