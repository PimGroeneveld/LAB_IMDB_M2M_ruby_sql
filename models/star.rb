require_relative("../db/sql_runner")

class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO stars (first_name, last_name) VALUES ($1, $2)
    RETURNING id"
    values = [@first_name, @last_name]
    location = SqlRunner.run(sql, values).first
    @id = location['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM stars"
    values = []
    stars = SqlRunner.run(sql, values)
    result = stars.map { |stars| Star.new(stars) }
    return result
  end

  def update()
    sql = "UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #find all movies for a star
  def movies()
    sql = "SELECT movies.* FROM movies INNER JOIN castings ON movies.id = castings.movie_id WHERE castings.star_id = $1"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    return movies.map {|movie| Movie.new(movie)}
  end

end
