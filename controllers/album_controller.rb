require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
require_relative( '../helpers/search.rb' )
also_reload( '../models/*' )
require 'pry'

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

get '/albums/:name/:counter/save' do
  id = save_album(params['name'], params['no'].to_i)
  redirect "/albums/#{id}/show"
end

get '/albums/find' do
  @album = Album.find(params['find_album'])
  id = @album.id
  redirect "/albums/#{id}/show"
end

get '/albums/:id/delete' do
  album = Album.find_by_id(params['id'].to_i)
  album.delete
  redirect '/albums'
end