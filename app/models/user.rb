class User < ApplicationRecord
    attr_accessor: remember_token
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { minimum: 4, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { minimum: 5, maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
    has_secure_password
    
    def User.new_token
        SecureRandom.urlsafe_base64
      end
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
end
