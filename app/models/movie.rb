class Movie < ActiveRecord::Base
  has_many :reviews
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: {
      only_integer: true
    }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validate :release_date_is_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected
    def release_date_is_past
      errors.add(:release_date, "should be in the past") if release_date.present? && release_date > Date.today 
    end
end
