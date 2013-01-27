class FreelancerData < ActiveRecord::Base
  attr_accessible :daily_rate, :status, :user_id

	belongs_to :user
  validates :daily_rate, numericality: { :only_integer => true }, presence: true, on: :update

  
end
