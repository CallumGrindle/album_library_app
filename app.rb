require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'sinatra/reloader' )
require 'rspotify'
require_relative('./secret/spotify_keys')
require_relative('./helpers/search')
require_relative('./controllers/album_controller')
require_relative('./controllers/artist_controller')
RSpotify.authenticate(@user_key, @secret_key)
require 'pry'

get '/' do
  erb( :index )
end


# binding.pry
