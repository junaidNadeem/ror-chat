class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type
  
  has_many :sent_messages, :class_name => "Message", :foreign_key => "sender_id"
  has_many :received_messages, :class_name => "Message", :foreign_key => "receiver_id"
  
  scope :all_except, lambda { |user| User.find(:all, :conditions => ["id != ?", user.id])}
  def self.USER_TYPES
    	[
    		["User", "user"],
    		["Trainer", "trainer"]
    	]
  end

  def user_stamp
    "#{self.email} (#{self.user_type})"
  end


  def chats
    sentMessages = self.sent_messages
    receivedMessages = self.received_messages
    senders = receivedMessages.pluck(:sender_id).uniq
    receivers = sentMessages.pluck(:receiver_id).uniq
    users = senders + receivers
    users  = User.where(id: users.uniq)
    users
  end
end
