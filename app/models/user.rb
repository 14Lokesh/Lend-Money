class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  before_save { self.email = email.downcase }
  before_save { self.name =  name.titleize }
  after_create :create_wallet

  has_one :wallet, dependent: :destroy
  has_many :loans, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX, message: 'must be a valid email address' },
                    uniqueness: { case_sensitive: false }         
  validates :password, presence: true 

  private
  
  def create_wallet
    Wallet.create(user: self, balance: self.admin ? 1000000 : 10000)
  end
end
