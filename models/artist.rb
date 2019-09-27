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

  def self.all
    sql = 'SELECT * FROM artists'
    result = SqlRunner.run(sql)
    return result.map { |artist_hash| Artist.new(artist_hash) }
  end

  def self.find(id)
    sql = 'SELECT * FROM artists WHERE artists.id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    hash = result[0]
    return Artist.new(hash)
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

end
