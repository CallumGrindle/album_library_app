require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )
require 'pry'

get '/artists' do
  @artists = Artist.all().sort_by { |album| album.name }
  erb ( :"artists/index" )
end

get '/artists/:id/show' do
  @artist = Artist.find_by_id( params['id'].to_i )
  erb ( :"artists/show")
end

get '/artists/:id/delete' do
  artist = Artist.find_by_id(params['id'].to_i)
  albums = artist.albums
  albums.each { |album| album.delete }
  artist.delete
  redirect '/artists'
end
