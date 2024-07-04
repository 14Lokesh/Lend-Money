class User < ApplicationRecord
  has_secure_password

  has_one :wallet

  after_create :create_wallet


	validates :name, :email,  presence: true, uniqueness: true
  validates :password, presence: true

  private

  def create_wallet
    Wallet.create(user: self, balance: self.admin ? 1000000 : 10000)
  end
end
