require 'pry'

class Album

  attr_accessor :title, :release_date
  attr_reader :artist_id

  def initialize(details)
    @id = details['id']
    @title = details['title']
    @release_date = details['release_date']
    @artist_id = details['artist_id']
  end

  def save
    
  end


end
