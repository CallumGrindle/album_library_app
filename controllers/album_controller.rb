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
  id = save_album(params['name'], params['counter'].to_i)
  redirect "/albums/#{id}/show"
end

get '/albums/find' do
  begin
    @album = Album.find(params['find_album'])
    id = @album.id
    redirect "/albums/#{id}/show"
  rescue
    redirect "/albums"
  end
end

get '/albums/:id/delete' do
  album = Album.find_by_id(params['id'].to_i)
  album.delete
  redirect '/albums'
end

get '/albums/:id/edit' do
  @album = Album.find_by_id(params['id'].to_i)
  @albums = Album.all
  erb (:'albums/edit')
end

put '/albums/:id' do
  album = Album.new(params).update
  redirect'/albums'
end

post '/save-album' do
  id = save_album(params)
  redirect "/albums/#{id}/show"
end

get '/:id/toggle-favourite' do
  id = params['id'].to_i
  @album = Album.find_by_id(id)
  @album.toggle_favourite
  redirect "/albums"
end

get '/:id/toggle-favourite/album-show' do
  id = params['id'].to_i
  @album = Album.find_by_id(id)
  @album.toggle_favourite
  redirect "/albums/#{id}/show"
end

get '/:id/toggle-favourite/artist-index' do
  id = params['id'].to_i
  @album = Album.find_by_id(id)
  @album.toggle_favourite
  redirect "/artists/#{id}/show"
end

get '/albums/favourites' do
  @albums = Album.all
  erb (:'albums/favourites')
end
