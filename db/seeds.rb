# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class Seed
  def self.start
    new.ideas
  end

  def ideas
    20.times do
      idea = Idea.create!(
        title: Faker::Lorem.word.capitalize,
        body: Faker::Lorem.sentence,
        quality: Faker::Number.between(0, 2)
      )
      puts "Idea #{idea.id}: #{idea.title}"
    end
  end
end

Seed.start
