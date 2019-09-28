require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )


get '/artists' do
  @artists = Artist.all().sort_by { |album| album.name }
  erb ( :"artists/index" )
end
