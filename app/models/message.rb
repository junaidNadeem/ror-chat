class Message < ActiveRecord::Base
  attr_accessible :message, :receiver_id, :sender_id

  validates :message, :presence => true
  validates :receiver_id, :presence => true
  validates :sender_id, :presence => true

  belongs_to :sender, :class_name=>'User', :foreign_key=>'sender_id'
  belongs_to :receiver, :class_name=>'User', :foreign_key=>'receiver_id'

  scope :conversation, lambda { |users| where(receiver_id: users).where(sender_id: users)}
end
