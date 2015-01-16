class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(position: :asc, updated_at: :desc) }
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  has_secure_password validations: false
  
  #before_create :generate_token  #the call to generate_token was moved to forgot_passwords_controller#create
  
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
  
  def follow(another_user)
    following_relationships.create(leader: another_user) if can_follow?(another_user)
  end
  
  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user)
  end
  
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
  
  def deactivate!
    update_column(:active, false)
  end
end