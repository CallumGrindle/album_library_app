require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )
require_relative('../secret/spotify_keys')
require 'rspotify'
RSpotify.authenticate(@user_key, @secret_key)




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
