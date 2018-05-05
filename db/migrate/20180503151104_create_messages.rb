class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.text :message, :null => false, :default => ""
    	t.integer :sender_id, :null => false
    	t.integer :receiver_id, :null => false
      t.timestamps
    end
  end
end
