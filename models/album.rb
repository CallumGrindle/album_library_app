require_relative('../db/sql_runner')
require 'pry'

class Album

  attr_accessor :title, :release_date
  attr_reader :artist_id

  def initialize(details)
    @id = details['id'] if details['id']
    @title = details['title']
    @release_date = details['release_date']
    @artist_id = details['artist_id']
    @album_art = details['album_art']
  end

  def save
    sql = 'INSERT INTO albums (title, release_date, artist_id, album_art)
          VALUES ($1, $2, $3, $4) RETURNING id'
    values = [@title, @release_date, @artist_id, @album_art]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def id
    return @id
  end

  def self.all
    sql = 'SELECT * FROM albums'
    result = SqlRunner.run(sql)
    return result.map { |album_hash| Album.new(album_hash) }
  end

  def self.find(id)
    sql = 'SELECT * FROM albums WHERE albums.id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    hash = result[0]
    return Album.new(hash)
  end

  def update
    sql = 'UPDATE albums SET title = $1, release_date = $2, artist_id = $3, album_art = $4 WHERE id = $5'
    values = [@title, @release_date, @artist_id, @album_art, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM albums'
    SqlRunner.run(sql)
  end

  def delete
    sql = 'DELETE FROM albums WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = 'DELETE FROM albums WHERE id = $1'
    values = [id]
    SqlRunner.run(sql, values)
  end


  # binding.pry
end
