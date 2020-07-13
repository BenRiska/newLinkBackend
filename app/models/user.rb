class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    has_many :langlinks
    has_many :languages, through: :langlinks
    has_many :chatlinks
    has_many :conversations, through: :chatlinks
    has_many :messages
end
