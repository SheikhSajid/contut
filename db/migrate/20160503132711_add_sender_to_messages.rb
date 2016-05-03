class AddSenderToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sender_tutor,    :boolean
    add_column :messages, :sender_student,  :boolean
  end
end
