class User < ApplicationRecord
  has_many :posts
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  has_secure_password

  validates_presence_of :first_name, :last_name, :email

  validates :first_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, length: { in: 1..20 }
  validates :last_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, length: { in: 1..20 }

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  before_save { self.email = email.downcase }

  validates :password, presence: true, length: { in: 6..20 }, allow_nil: true

  enum role: { user: 0, admin: 1 }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
