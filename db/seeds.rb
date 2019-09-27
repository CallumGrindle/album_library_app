require_relative('../secret/spotify_keys')
require_relative('../models/album')
require_relative('../models/artist')
require 'rspotify'
RSpotify.authenticate(@user_key, @secret_key)
require 'pry'

# artists = RSpotify::Artist.search('Mitch Murder')
# tracks = RSpotify::Track.search('Breeze')

def album_search(album_title)
  album_search = RSpotify::Album.search(album_title)
  album_spotify_object = album_search[0]
  artist_details = {'name' => album_spotify_object.artists.first.name}
  artist = Artist.new(artist_details)
  artist.save
  album_details = {'title' => album_spotify_object.name, 'release_date' => album_spotify_object.release_date, 'artist_id' => artist.id, 'album_art' => album_spotify_object.images[0]['url']}
  album = Album.new(album_details)
  album.save
end

album_search("You Won't Get What You Want")
album_search("Pleasure Suck")
album_search("Current Events")
album_search("Charli")
album_search("Negative Hope Records Launch Sampler")
album_search("Nunia")
album_search("Static Age")
