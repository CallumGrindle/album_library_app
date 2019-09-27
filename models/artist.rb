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


end
