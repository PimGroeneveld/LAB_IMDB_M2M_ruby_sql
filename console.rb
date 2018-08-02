require_relative('models/casting')
require_relative('models/movie')
require_relative('models/star')

require('pry-byebug')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie1 = Movie.new({
  "title" => "Shawshank Redemption",
  "genre" => "Prison Break",
  "budget" => 1000000
  })

movie1.save()

movie2 = Movie.new({
  "title" => "The Big Lebowksi",
  "genre" => "Indie",
  "budget" => 500000
  })

movie2.save()

star1 = Star.new({
  "first_name" => "Tom",
  "last_name" => "Hanks"
  })

star1.save()

star2 = Star.new({
  "first_name" => "Jeff",
  "last_name" => "Bridges"
  })

star2.save()

cast1 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star1.id,
  "fee" => 200000
  })

cast1.save()

cast2 = Casting.new({
  "movie_id" => movie2.id,
  "star_id" => star2.id,
  "fee" => 100000
  })

cast2.save()

binding.pry
nil
