class Project < ApplicationRecord
  
  has_one_attached :image
  
  validates :name, :description, :creator_email, presence: true
  validate :image_presence

  private 

  def image_presence
    unless self.image.attached?
      errors.add(:image, "must be present.")
    end
  end
end
