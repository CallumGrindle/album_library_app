require_relative('../secret/spotify_keys')
require_relative('../models/album')
require_relative('../models/artist')
require 'rspotify'
RSpotify.authenticate(@user_key, @secret_key)
require 'pry'

# artists = RSpotify::Artist.search('Mitch Murder')
# tracks = RSpotify::Track.search('Breeze')

def search_album(album_title)
  return album_search = RSpotify::Album.search(album_title)
end

def save_album(params)
  artist_details = {'name' => params['artist_name']}
  if Artist.artist_exists?(artist_details['name']) == false
    artist = Artist.new(artist_details)
    artist.save
  elsif Artist.artist_exists?(artist_details['name']) == true
    artist = Artist.find(artist_details['name'])
  end
  album_details = {'title' => params['title'], 'release_date' => params['release_date'], 'artist_id' => artist.id, 'art' => params['artwork']}
  album = Album.new(album_details)
  album.save
  return album.id
end
