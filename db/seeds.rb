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
