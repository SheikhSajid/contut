class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :title
      t.string :grade

      t.timestamps null: false
    end
  end
end
