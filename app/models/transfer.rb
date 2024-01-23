class Transfer < ApplicationRecord

  has_one :user
  # encrypts :sender_account_number 
  # encrypts :receiver_account_number 
  encrypts :amount 

  validates :amount, presence: true, format: { with: /\A\d+(\.\d+)?\z/, message: "is incorrect" }, numericality: { greater_than: 0 }
  validates :sender_account_number, presence: true, format: { with: /\A\d{26}\z/, message: "is incorrect" }
  validates :receiver_account_number, presence: true, format: { with: /\A\d{26}\z/, message: "is incorrect" }
  validates :title, presence: true, format: { with: /\A[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\d\s,\-;!"?]+\z/, message: "is incorrect" }
  validates :name, presence: true, format: { with: /\A[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\s,\-]+\z/, message: "is incorrect" }
  validates :address, presence: true, format: { with: /\A[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\d\s,\-]+\z/, message: "is incorrect" }
end