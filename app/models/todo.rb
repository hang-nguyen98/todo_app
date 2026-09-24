class Todo < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates :title, presence: true
  validates :category_id, presence: true

  def when
		"Created on #{ self.created_at.strftime("%m/%d/%Y at %H:%M") }"
  end

end
