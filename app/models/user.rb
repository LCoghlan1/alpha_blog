class User < ApplicationRecord
    
    #reference each object of the class and downcase it before saving
    before_save { self.email = email.downcase }
    
    #create a one to many relationship between articles
    has_many :articles
    
    #ensure username is present, unique (incl. case sensitivity) and of certain length before a user object is saved to db
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum:3, maximum: 25}
    
    #regex saved as constant as will not change
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 105}, format: { with: VALID_EMAIL_REGEX }
    
    has_secure_password
    
end