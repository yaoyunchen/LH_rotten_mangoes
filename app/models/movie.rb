class Movie < ActiveRecord::Base
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


  protected
    def release_date_is_past
      errors.add(:release_date, "should be in the past") if release_date.present? && release_date > Date.today 
    end
end
