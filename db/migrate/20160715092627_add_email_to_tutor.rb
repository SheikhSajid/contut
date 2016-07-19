class AddEmailToTutor < ActiveRecord::Migration
  # Adds email back to Tutor, this time following the devise migration
  def self.up
    change_table :tutors do |t|
      ## Database authenticatable
      t.string :email, null: false, default: ""
    end
    
    add_index :tutors, :email, unique: true
  end
  
  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
