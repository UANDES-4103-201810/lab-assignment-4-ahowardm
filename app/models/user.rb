class User < ApplicationRecord
  has_many :user_tickets
  has_many :tickets, :through => :user_tickets
  validates :phone, length:  {minimum: 9, maximum: 12}
  validates :phone, numericality: { only_integer: true }
  validates :password, length: {minimum: 8, maximum: 12}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: "invalid email address" }
end