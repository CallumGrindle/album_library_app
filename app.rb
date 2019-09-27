require_relative('./secret/spotify_keys')
require_relative('./models/album')
require_relative('./models/artist')
require 'rspotify'
RSpotify.authenticate(@user_key, @secret_key)
require 'pry'

# binding.pry
