class AddAvgAndNoOfReviewsToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :avg, :float, default: 0
    add_column :tutors, :no_of_reviews, :integer, default: 0
  end
end
