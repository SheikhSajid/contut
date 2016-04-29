module ReviewsHelper
  def number_of_reviews
    if @reviews and @reviews.length == 1
      return "#{@reviews.length} review"
    elsif @reviews
      return "#{@reviews.length} reviews"
    else
      return 0
    end
  end
end
