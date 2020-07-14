class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    has_many :langlinks
    has_many :languages, through: :langlinks
    has_many :chatlinks
    has_many :conversations, through: :chatlinks
    has_many :messages


    def self.checkParams (params)
        if params["username"].length > 0 && params["name"].length > 0 && params["email"].length > 0 && params["password"].length > 0
            true
        elsif 
            false
        end
    end
end
