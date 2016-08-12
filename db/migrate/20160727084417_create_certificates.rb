class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.integer :tutor_id

      t.timestamps null: false
    end
  end
end
