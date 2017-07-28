class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end
end
