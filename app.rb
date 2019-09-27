require_relative('./secret/spotify_keys')
require_relative('./models/album')
require_relative('./models/artist')
require 'rspotify'
RSpotify.authenticate(@user_key, @secret_key)
require 'pry'


album = Album.find(3)
album.delete

Album.delete(2)

artist = Artist.find(3)
artist.delete

Artist.delete(2) 



# binding.pry
