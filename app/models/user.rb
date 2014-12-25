class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(position: :asc, updated_at: :desc) }
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  
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
  
  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end
end