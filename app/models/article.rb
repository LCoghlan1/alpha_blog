class Article < ApplicationRecord
    
    #create one to many relationship with users (it belongs to users)
    belongs_to :user
    
    validates :title, presence: true, length: { minimum: 3, maximum: 100 }
    validates :description, presence: true, length: {minimum: 3, maximum: 500 }
end