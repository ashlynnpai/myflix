class Video < ActiveRecord::Base
  belongs_to :category
  
  validates :title, presence: true
  validates :description, presence: true
  
  def self.search_by_title(str)
    return [] if str.blank?
    where("title LIKE ?", "%#{str}%").order("created_at DESC")
  end
  
end