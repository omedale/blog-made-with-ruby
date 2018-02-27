class Post < ApplicationRecord
    #user is single here because is 1:M associaion. one users to many articles
    belongs_to :user
    has_many :comments
    has_many :post_categories
    has_many :categories, through: :post_categories
    validates :title, presence: true,
                       length: {minimum: 5}
    validates :user_id, presence: true
end
