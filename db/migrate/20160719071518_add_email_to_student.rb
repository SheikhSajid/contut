class AddEmailToStudent < ActiveRecord::Migration
  # Adds email back to Student, this time following the devise migration
  def self.up
    change_table :students do |t|
      ## Database authenticatable
      t.string :email, null: false, default: ""
    end
    
    add_index :students, :email, unique: true
  end
  
  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
