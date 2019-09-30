require_relative('../db/sql_runner')
require 'pry'

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(details)
    @id = details['id'] if details['id']
    @name = details['name']
  end

  def save
    sql = 'INSERT INTO artists (name)
          values ($1) RETURNING id'
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def albums
    sql = 'SELECT albums.* FROM albums
        INNER JOIN artists ON artists.id = albums.artist_id
        WHERE artists.id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |album| Album.new(album) }
  end

  def self.all
    sql = 'SELECT * FROM artists'
    result = SqlRunner.run(sql)
    return result.map { |artist_hash| Artist.new(artist_hash) }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM artists WHERE artists.id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    # binding.pry
    hash = result[0]
    return Artist.new(hash)
  end

  def self.find(name)
    sql = 'SELECT * FROM artists WHERE artists.name = $1'
    values = [name]
    result = SqlRunner.run(sql, values)
    if result.count >=1
      hash = result[0]
      return Artist.new(hash)
    end
    return nil
  end

  def self.artist_exists?(name)
    if Artist.find(name) != nil
      return true
    end
    return false
  end

  def update
    sql = 'UPDATE artists SET name = $1 WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM artists'
    SqlRunner.run(sql)
  end

  def delete
    sql = 'DELETE FROM artists WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = 'DELETE FROM artists WHERE id = $1'
    values = [id]
    SqlRunner.run(sql, values)
  end

end
