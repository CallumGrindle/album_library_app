require_relative('../db/sql_runner')
require 'pry'

class Album

  attr_accessor :title, :release_date, :art, :favourite, :spotify_link
  attr_reader :artist_id, :id

  def initialize(details)
    @id = details['id'] if details['id']
    @title = details['title']
    @release_date = details['release_date']
    @artist_id = details['artist_id']
    @art = details['art']
    @favourite = details['favourite']
    @spotify_link = details['spotify_link']
  end

  def save
    sql = 'INSERT INTO albums (title, release_date, artist_id, art, favourite, spotify_link)
          VALUES ($1, $2, $3, $4, $5, $6) RETURNING id'
    values = [@title, @release_date, @artist_id, @art, @favourite=false, @spotify_link]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def artist
    sql = 'SELECT name, artists.id FROM artists
          INNER JOIN albums ON albums.artist_id = artists.id
          WHERE albums.id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

  def self.all
    sql = 'SELECT * FROM albums'
    result = SqlRunner.run(sql)
    return result.map { |album_hash| Album.new(album_hash) }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM albums WHERE albums.id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    hash = result[0]
    return Album.new(hash)
  end

  def self.find(title)
    title = title.split.map(&:capitalize).join(' ')
    title = "%#{title}%"
    sql = "SELECT * FROM albums WHERE albums.title LIKE $1"
    values = [title]
    result = SqlRunner.run(sql, values)
    hash = result[0]
    return Album.new(hash)
  end

  def update
    sql = 'UPDATE albums SET title = $1, release_date = $2, artist_id = $3, art = $4, favourite = $5, spotify_link = $6 WHERE id = $7'
    values = [@title, @release_date, @artist_id, @art, @favourite, @spotify_link, @id]
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

  def toggle_favourite
    if @favourite == 't'
      @favourite = 'f'
    else
      @favourite = 't'
    end
    sql = 'UPDATE albums SET favourite = $1 WHERE id = $2'
    values = [@favourite, @id]
    SqlRunner.run(sql, values)
  end

  def favourite?
    return true if @favourite == 't'
    return false if @favourite == 'f'
  end

  def self.random_id
    albums = Album.all
    arr = albums.map { |album| album.id }
    rand_id = arr.sample
  end

  def self.count
    return Album.all.count
  end

end
