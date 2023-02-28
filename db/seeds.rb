# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
unless User.where(email: "admin@email.com").any?
    User.create!(
        first_name: "Admin",
        last_name: "Account",
        email: "admin@email.com",
        password: "admin123",
        role: "admin"
    )
end
