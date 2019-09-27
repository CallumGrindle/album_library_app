require_relative('./secret/spotify_keys')
require_relative('./models/album')
require_relative('./models/artist')
require 'rspotify'
RSpotify.authenticate(@user_key, @secret_key)
require 'pry'


# artists = RSpotify::Artist.search('Mitch Murder')
# tracks = RSpotify::Track.search('Breeze')
albums = RSpotify::Album.search("Nevermind")


nevermind_object = albums[0]

nirvana_details = {'name' => nevermind_object.artists.first.name}
nirvana = Artist.new(nirvana_details)
# nirvana.save
nevermind_details = {'title' => nevermind_object.name, 'release_date' => nevermind_object.release_date}
nevermind = Album.new(nevermind_details)
# nevermind.save

binding.pry
