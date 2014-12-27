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
Video.create(title: "Mutant Love 2", description: "Show about mutant meets pizza boy 2", small: "futurama.jpg", large: "futurama.jpg", category_id: "1")
 Video.create(title: "Talking Baby 2", description: "Show about a baby 2", small: "family_guy.jpg", large: "family_guy.jpg", category_id: "1")
Video.create(title: "Flapping Heads 2", description: "Why do their heads flap? 2", small: "south_park.jpg", large: "south_park.jpg", category_id: "1")
Video.create(title: "Mutant Love 3", description: "Show about mutant meets pizza boy 3", small: "futurama.jpg", large: "futurama.jpg", category_id: "1")
 Video.create(title: "Talking Baby 3", description: "Show about a baby 3", small: "family_guy.jpg", large: "family_guy.jpg", category_id: "1")
Video.create(title: "Flapping Heads 3", description: "Why do their heads flap? 3", small: "south_park.jpg", large: "south_park.jpg", category_id: "1")

 robot = Video.create(title: "Robot", description: "Show about robots", small: "futurama.jpg", large: "futurama.jpg", category_id: "2")
dog = Video.create(title: "Talking Dog", description: "Show about a dog", small: "family_guy.jpg", large: "family_guy.jpg", category_id: "2")
Video.create(title: "My Gang", description: "Show about kids", small: "south_park.jpg", large: "south_park.jpg", category_id: "2")
 Video.create(title: "Robot 2", description: "Show about robots 2", small: "futurama.jpg", large: "futurama.jpg", category_id: "2")
 Video.create(title: "Talking Dog 2", description: "Show about a dog 2", small: "family_guy.jpg", large: "family_guy.jpg", category_id: "2")
Video.create(title: "My Gang 2", description: "Show about kids 2", small: "south_park.jpg", large: "south_park.jpg", category_id: "2")
 Video.create(title: "Robot 3", description: "Show about robots 3", small: "futurama.jpg", large: "futurama.jpg", category_id: "2")
 Video.create(title: "Talking Dog 3", description: "Show about a dog 3", small: "family_guy.jpg", large: "family_guy.jpg", category_id: "2")
Video.create(title: "My Gang 3", description: "Show about kids 3", small: "south_park.jpg", large: "south_park.jpg", category_id: "2")


