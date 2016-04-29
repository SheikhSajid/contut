module StudentsHelper
  def reviews_written
    if @reviews.blank?
      return 0
    else
      return @reviews.length
    end
  end
end
