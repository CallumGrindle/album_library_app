DROP TABLE ALBUMS;
DROP TABLE ARTISTS;

CREATE TABLE artists (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE albums (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  release_date VARCHAR(255),
  artist_id INT4 REFERENCES artists(id) ON DELETE CASCADE,
  art VARCHAR(255),
  favourite BOOLEAN DEFAULT false NOT NULL,
  spotify_link VARCHAR(255)
);
