CREATE TABLE IF NOT EXISTS Genres (
	genres_id SERIAL PRIMARY KEY,
	genres_name VARCHAR(100) NOT NULL,
	CONSTRAINT co_genres_name UNIQUE(genres_name)
);


CREATE TABLE IF NOT EXISTS Singer (
	singer_id SERIAL PRIMARY KEY,
	singer_name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Singer_genres (
	id SERIAL PRIMARY KEY,
	genres_id INTEGER NOT NULL REFERENCES Genres(genres_id),
	singer_id INTEGER NOT NULL REFERENCES Singer(singer_id)
); 

CREATE TABLE IF NOT EXISTS Album (
	album_id SERIAL PRIMARY KEY,
	album_name VARCHAR(60) NOT NULL,
	release_date INTEGER NOT NULL,
	CHECK(release_date >= 1900 AND release_date <= 2050)
);
	
CREATE TABLE IF NOT EXISTS Album_singer (
	id SERIAL PRIMARY KEY,
	singer_id INTEGER NOT NULL REFERENCES Singer(singer_id),
	album_id INTEGER NOT NULL REFERENCES Album(album_id)
);
	
CREATE TABLE IF NOT EXISTS Track (
	track_id SERIAL PRIMARY KEY,
	track_name VARCHAR(60)NOT NULL,
	track_time TIME NOT NULL,
	album_id INTEGER NOT NULL REFERENCES Album(album_id)
);
	
CREATE TABLE IF NOT EXISTS Collection (
	collection_id SERIAL PRIMARY KEY,
	collection_name VARCHAR(60) NOT NULL,
	release_date INTEGER NOT NULL,
	CHECK(release_date >= 1900 AND release_date <= 2050)
);
	
CREATE TABLE IF NOT EXISTS Collection_track (
	id SERIAL PRIMARY KEY,
	track_id INTEGER NOT NULL REFERENCES Track(track_id),
	collection_id INTEGER NOT NULL REFERENCES Collection(collection_id)
);