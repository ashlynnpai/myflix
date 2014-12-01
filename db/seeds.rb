# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: "TV Comedies")
Category.create(name: "TV Dramas")



Video.create(title: "Mutant Love", description: "Show about mutant meets pizza boy", small: "futurama.jpg", large: "futurama.jpg", category_id: "1")
 Video.create(title: "Talking Baby", description: "Show about a baby", small: "family_guy.jpg", large: "family_guy.jpg", category_id: "1")
Video.create(title: "Flapping Heads", description: "Why do their heads flap?", small: "south_park.jpg", large: "south_park.jpg", category_id: "1")

 Video.create(title: "Robot", description: "Show about robots", small: "futurama.jpg", large: "futurama.jpg", category_id: "2")
 Video.create(title: "Talking Dog", description: "Show about a dog", small: "family_guy.jpg", large: "family_guy.jpg", category_id: "2")
Video.create(title: "My Gang", description: "Show about kids", small: "south_park.jpg", large: "south_park.jpg", category_id: "2")
