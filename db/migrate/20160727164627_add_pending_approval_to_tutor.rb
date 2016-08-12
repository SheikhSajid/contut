class AddPendingApprovalToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :pending_approval, :boolean, default: false
  end
end
