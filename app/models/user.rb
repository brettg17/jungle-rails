class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  
  def self.authenticate_with_credentials(email, password)
    cleaned_email = email.strip.downcase
    user = User.find_by(email: cleaned_email)
    user && user.authenticate(password) ? user : nil
  end
end