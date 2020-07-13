class Language < ApplicationRecord
    has_many :langlinks
    has_many :users, through: :langlinks
end
