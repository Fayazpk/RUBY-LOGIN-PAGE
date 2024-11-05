class User < ApplicationRecord
    has_secure_password
    
    validates :email, presence: true, uniqueness: true, format: { 
        with: /\A(?!.*@.*@)(?!.*@.*\..*\.)[a-zA-Z0-9._%+-]{3,}@[a-zA-Z0-9.-]{3,}\.[a-zA-Z]{2,}\z/,
        message: "must be valid and meet our requirements" 
      }
    
    before_validation :normalize_email

    def self.authenticate(email, password)
        user = find_by(email: email)
        user && user.authenticate(password)
    end

    def admin?
        self.admin
    end

    private

    def normalize_email
        self.email = email.strip.downcase if email.present?
    end
    
end
   
 
