class Movie < ActiveRecord::Base
  scope :search, -> (search) {where("title like ? OR director like ?", "%#{search}%", "%#{search}%")}
  scope :duration, -> (runtime_in_minutes) {
    if runtime_in_minutes.nil?
      all
    else
      case runtime_in_minutes 
      when 'Under 90 minutes'
        where("runtime_in_minutes < 90")
      when 'Between 90 and 120 minutes'
        where("runtime_in_minutes >= 90 AND runtime_in_minutes < 120")
      when 'Over 120 minutes'
        where("runtime_in_minutes >= 120")
      end
    end
  }

  mount_uploader :image, ImageUploader

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

  # validates :poster_image_url,
  #  presence: true

  # validates :image,
  #  presence: true

  validate :release_date_is_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected
    def release_date_is_past
      errors.add(:release_date, "should be in the past") if release_date.present? && release_date > Date.today 
    end

    # self
    #   def self.search(search_title, search_director, search_runtime)
    #     return all unless search_title.present? || search_director.present? || search_runtime.present?

    #     if search_runtime.present?
    #       case search_runtime 
    #       when 'Under 90 minutes'
    #         where(["title LIKE ? AND director LIKE ? AND runtime_in_minutes < 90", "%#{search_title}%", "%#{search_director}%"])
    #       when 'Between 90 and 120 minutes'
    #         where(["title LIKE ? AND director LIKE ? AND (runtime_in_minutes >= 90 AND runtime_in_minutes < 120) ", "%#{search_title}%", "%#{search_director}%"])
    #       when 'Over 120 minutes'
    #         where(["title LIKE ? AND director LIKE ? AND runtime_in_minutes >= 120", "%#{search_title}%", "%#{search_director}%"])
    #       end
    #     else
    #       where(["title LIKE ? AND director LIKE ?", "%#{search_title}%", "%#{search_director}%"])
    #     end

    #   end
end
