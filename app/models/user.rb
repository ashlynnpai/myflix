class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order(position: :asc, updated_at: :desc) }

  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  has_secure_password validations: false
  
  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end
  
  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end
end