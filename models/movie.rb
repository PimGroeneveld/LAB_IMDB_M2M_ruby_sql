require_relative("../db/sql_runner")

class Movie

  attr_reader :id
  attr_accessor :title, :genre   #, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    # @budget = options['budget'].to_i
  end

  # Create
  def save()
    sql = "INSERT INTO movies(title, genre) VALUES ($1, $2)
    RETURNING id"
    values = [@title, @genre]
    location = SqlRunner.run(sql, values).first
    @id = location['id'].to_i
  end

  # Read
  def self.all()
    sql = "SELECT * FROM movies"
    values = []
    movies = SqlRunner.run(sql, values)
    result = movies.map { |movies| Movie.new(movies) }
    return result
  end

  #Update
  def update()
    sql = "UPDATE movies SET (title, genre) = ($1, $2) WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  #Delete
  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #Find all stars for a film
  def stars()
    sql = "SELECT stars.* FROM stars INNER JOIN castings ON stars.id = castings.star_id WHERE castings.movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    return stars.map {|star| Star.new(star)}
  end

  # def budget_count()
  #   sql = "SELECT COUNT movies.* FROM movies INNER JOIN castings ON movies.budget = castings.fee WHERE castings.movie_id = $1"
  #   values = [@id]
  #   budget_count = budget { |fee| fee }
  #   return budget_count
  # end


end
