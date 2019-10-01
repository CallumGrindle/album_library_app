require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'sinatra/reloader')
require_relative('./controllers/album_controller')
require_relative('./controllers/artist_controller')
require 'pry'

get '/' do
  erb( :index )
end


# binding.pry
