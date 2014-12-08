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

user1 = User.create(name: "Happy Hippo", password: "password1", email: "user1@email.com")

Review.create(user: user1, video: robot, rating: 3, content: "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided.")

Review.create(user: user1, video: dog, rating: 4, content: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.")
