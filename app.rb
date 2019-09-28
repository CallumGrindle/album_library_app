require( 'sinatra' )
require( 'sinatra/contrib/all' )
require 'rspotify'
require_relative('./secret/spotify_keys')
RSpotify.authenticate(@user_key, @secret_key)
require_relative('./controllers/album_controller')
require_relative('./controllers/artist_controller')
require 'pry'

get '/' do
  erb( :index )
end


# binding.pry
