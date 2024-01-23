class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable
  has_many :combinations, dependent: :destroy
  has_many :transfers, dependent: :destroy

  validates :account_no, uniqueness: true

  encrypts :money 
  encrypts :id_number 
  encrypts :card_number
end
