class MessagesController < ApplicationController
	before_filter :authenticate_user!


	def new
		@message = Message.new()
	end


	def create
		@message = Message.new params[:message]
		if @message.save
      redirect_to messenger_path, :notice => "Message has been added"
    else
      redirect_to new_message_path, :alert => "Message not created. Please review form and submit again"
    end
	end
end
