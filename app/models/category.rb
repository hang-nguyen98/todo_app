class Category < ApplicationRecord
  belongs_to :user

  # Destroy a category's todos if the category is deleted
  has_many :todos, dependent: :destroy
  validates :name, presence: true
end
