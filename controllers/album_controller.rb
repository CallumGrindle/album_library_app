require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )


get '/albums' do
  @albums = Album.all()
  erb ( :"albums/index" )
end
