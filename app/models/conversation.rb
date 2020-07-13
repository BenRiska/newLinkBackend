class Conversation < ApplicationRecord
    has_many :chatlinks
    has_many :users, through: :chatlinks
    has_many :messages
end
