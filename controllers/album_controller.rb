require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )



get '/albums' do
  @albums = Album.all().sort_by { |album| album.title }
  erb ( :"albums/index" )
end

get '/albums/:id/show' do
  @album = Album.find_by_id(params['id'].to_i)
  erb ( :"albums/show" )
end

get '/albums/search' do
  erb (:"albums/search")
end

get '/albums/add' do
  erb (:"albums/add")
end

post '/albums/add' do

end
