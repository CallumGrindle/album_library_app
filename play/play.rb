require 'pry'
require 'rspotify'
require_relative('../secret/spotify_keys')

RSpotify.authenticate(@user_key, @secret_key)

artists = RSpotify::Artist.search('Mitch Murder')

# arctic_monkeys = artists.first
# arctic_monkeys.popularity      #=> 74
# arctic_monkeys.genres          #=> ["Alternative Pop/Rock", "Indie", ...]
# arctic_monkeys.top_tracks(:US) #=> (Track array)
#
# albums = arctic_monkeys.albums
# albums.first.name #=> "AM"
#
# am = albums.first
# am.release_date      #=> "2013-09-10"
# am.images            #=> (Image array)
# am.available_markets #=> ["AR", "BO", "BR", ...]
#
# tracks = am.tracks
# tracks.first.name #=> "Do I Wanna Know?"
#
# do_i_wanna_know = tracks.first
# do_i_wanna_know.duration_ms  #=> 272386
# do_i_wanna_know.track_number #=> 1
# do_i_wanna_know.preview_url  #=> "https://p.scdn.co/mp3-preview/<id>"
# #
playlists = RSpotify::Playlist.search('Indie')
playlists.first.name #=> "The Indie Mix"

# You can search within other types too
albums = RSpotify::Album.search("Pleasure Suck")
tracks = RSpotify::Track.search('Breeze')




binding.pry
nil
