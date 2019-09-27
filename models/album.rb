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
  end

  def save
    sql = 'INSERT INTO albums (title, release_date, artist_id)
          VALUES ($1, $2, $3) RETURNING id'
    values = [@title, @release_date, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end


end
