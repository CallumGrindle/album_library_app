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


def save_album(album)
  artist_details = {'name' => album.artists.first.name}
  if Artist.artist_exists?(artist_details['name']) == false
    artist = Artist.new(artist_details)
    artist.save
  elsif Artist.artist_exists?(artist_details['name']) == true
    artist = Artist.find(artist_details['name'])
  end
  album_details = {'title' => album.name, 'release_date' => album.release_date, 'artist_id' => artist.id, 'art' => album.images[0]['url']}
  album = Album.new(album_details)
  album.save
  return album.id
end





# def save_album(album_title, n)
#   album_spotify_object = search_album(album_title)[n]
#   artist_details = {'name' => album_spotify_object.artists.first.name}
#   if Artist.artist_exists?(artist_details['name']) == false
#     artist = Artist.new(artist_details)
#     artist.save
#   elsif Artist.artist_exists?(artist_details['name']) == true
#     artist = Artist.find(artist_details['name'])
#   end
#   album_details = {'title' => album_spotify_object.name, 'release_date' => album_spotify_object.release_date, 'artist_id' => artist.id, 'art' => album_spotify_object.images[0]['url']}
#   album = Album.new(album_details)
#   album.save
#   return album.id
# end
