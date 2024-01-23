# app/models/combination.rb
require 'bcrypt'

class Combination < ApplicationRecord
  belongs_to :user

  # attr_accessor :password

  # before_save :hash_combination

  # # Koszt dla bcrypt
  # COST = 12

  # private

  # def hash_combination
  #   # Używamy BCrypt::Password.create do utworzenia soli i zahashowania hasła
  #   bcrypt = BCrypt::Password.create(hashed_combination)
  #   self.salt = bcrypt.salt
  #   self.hashed_combination = bcrypt
  # end

end
