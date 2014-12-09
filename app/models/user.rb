class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  has_secure_password validations: false
end