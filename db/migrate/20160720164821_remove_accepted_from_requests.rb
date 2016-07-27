class RemoveAcceptedFromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :accepted
  end
end
