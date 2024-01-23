# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create!(
  email: 'user1@pl.pl',
  password: 'pass3#WO11rd!?',
)

# User 2
user2 = User.create!(
  email: 'user2@pl.pl',
  password: 'G$7tL9zW1qXp2',
)

# User 3
user3 = User.create!(
  email: 'user3@pl.pl',
  password: 'uX5vG#zLmY9sR3kPw',
)

# User 4
user4 = User.create!(
  email: 'user4@pl.pl',
  password: 'u^5FzG8sW!rLkZ2vq;',
)

