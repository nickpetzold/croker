class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :top_ups
  has_many :trades
  has_many :portfolios
  monetize :fiat_balance_cents
  validates :first_name, :last_name, :email, :country, :fiat_balance_cents, presence: true
end
