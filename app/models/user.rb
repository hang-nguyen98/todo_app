class User < ApplicationRecord
  # normalization: downcase the email before saving to the database
  before_save {
		self.email = email.downcase
	}
  has_secure_password
  # destroy a user's todos/categories if their account is deleted
  has_many :categories, dependent: :destroy
  has_many :todos, dependent: :destroy

  # first name, last name, email, and username are required fields
  validates :first_name, presence: true
  validates :last_name, presence: true
  # email and username must be unique and case insensitive.
  validates :email, 
            presence: true, 
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email must be valid" },
            uniqueness: { case_sensitive: false, message: "Email must be unique" }
  validates :username, 
            presence: true, 
            uniqueness: { case_sensitive: false, message: "Username must be unique" }

  def details
		"Joined on #{ self.created_at.strftime("%m/%d/%Y at %H:%M") }"
  end

	def to_s
		"Name: #{username}, Email: #{email}"
	end

	def todos_count
		todos.count
	end
end
