class User < ActiveRecord::Base
  
  
  attr_accessible :email, :name, :role, :password, :password_confirmation
  has_secure_password

  has_one :freelancer_data
  #accepts_nested_attributes_for :freelancer_data

  

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_create :create_freelancer_data_record

  validates :name, presence: true, length: {maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  									format: { with: VALID_EMAIL_REGEX }, 
  									uniqueness: { case_sensitive: false }
  
  validates :password, presence: true, length: {minimum:6}, on: :create
  validates :password_confirmation, presence: true, on: :create

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_freelancer_data_record
      z = FreelancerData.new(status: "available", daily_rate: 0, user_id: self.id)
      z.save
    end

end
