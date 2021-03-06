
CREATE TABLE public.movie_type
(
  id integer NOT NULL,
  kind character varying(50),
  CONSTRAINT movie_type5_pkey PRIMARY KEY (id)
);
copy movie_type from 'C:/Personal/Data/imdb/movie_type.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE info_type(
	id INT NOT NULL,
	info VARCHAR(50),
	PRIMARY KEY(id)
);
copy info_type from 'C:/Personal/Data/imdb/info_type.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE keyword(
	id INT,
	keyword VARCHAR(125),
	PRIMARY KEY(id)
);
copy keyword from 'C:/Personal/Data/imdb/keyword.csv' DELIMITER ',' HEADER CSV;

/* reading table person */
CREATE TABLE person(
	id INT NOT NULL,
	name VARCHAR(180) NOT NULL,
	gender CHAR,
	PRIMARY KEY(id)
);
copy person from 'C:/Personal/Data/imdb/person.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE company(
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	country_code VARCHAR(8)
);
copy company from 'C:/Personal/Data/imdb/company.csv' DELIMITER ',' HEADER CSV;

/* more movie.csv | cut -d ',' -f2 | wc -L */
CREATE TABLE movie(
	id INT NOT NULL PRIMARY KEY,
	title VARCHAR(320) NOT NULL,
	kind_id INT NOT NULL REFERENCES movie_type(id),
	production_year INT,
	episode_of_id INT REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	season_nr INT,
	episode_nr INT,
	series_years VARCHAR(10)
);
copy movie from 'C:/Personal/Data/imdb/movie.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE aka_name(
	id INT NOT NULL PRIMARY KEY,
	person_id INT NOT NULL REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE,
	name VARCHAR(250)
);
copy aka_name from 'C:/Personal/Data/imdb/aka_name.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE aka_title(
	id INT NOT NULL PRIMARY KEY,
	movie_id INT NOT NULL,
	title VARCHAR(600),
	kind_id INT NOT NULL REFERENCES movie_type(id),
	production_year INT,
	episode_of_id INT REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	season_nr INT,
	episode_nr INT,
	note VARCHAR(250),
	CONSTRAINT movie_fk FOREIGN KEY(movie_id)
	REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE aka_title
DROP CONSTRAINT movie_fk
copy aka_title from 'C:/Personal/Data/imdb/aka_title.csv' DELIMITER ',' HEADER CSV;

DELETE FROM aka_title
WHERE
	NOT EXISTS (SELECT 1 FROM movie WHERE movie.id=aka_title.movie_id)

ALTER TABLE aka_title
ADD CONSTRAINT movie_fk
FOREIGN KEY(movie_id)
REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE

CREATE TABLE link_type(
	id INT NOT NULL PRIMARY KEY,
	link VARCHAR(40) NOT NULL
);
copy link_type from 'C:/Personal/Data/imdb/link_type.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE movie_link(
	id INT NOT NULL PRIMARY KEY,
	movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	linked_movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	link_type_id INT NOT NULL REFERENCES link_type(id)
);
copy movie_link from 'C:/Personal/Data/imdb/movie_link.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE movie_rating(
	id INT NOT NULL PRIMARY KEY,
	movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	info_type_id INT NOT NULL REFERENCES info_type(id) ON UPDATE CASCADE ON DELETE NO ACTION,
	info VARCHAR(30) NOT NULL
);
copy movie_rating from 'C:/Personal/Data/imdb/movie_rating.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE char_name(
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(500) NOT NULL
);
copy char_name from 'C:/Personal/Data/imdb/char_name.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE comp_cast_type(
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(20) NOT NULL
);
copy comp_cast_type from 'C:/Personal/Data/imdb/comp_cast_type.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE person_info(
	id INT NOT NULL PRIMARY KEY,
	person_id INT NOT NULL REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE,
	info_type_id INT NOT NULL REFERENCES info_type(id) ON DELETE NO ACTION ON UPDATE CASCADE,
	info VARCHAR(55900),
	note VARCHAR(400)
);
copy person_info from 'C:/Personal/Data/imdb/person_info.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE role_type(
	id INT NOT NULL PRIMARY KEY,
	role VARCHAR(20)
);

copy role_type from 'C:/Personal/Data/imdb/role_type.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE cast_info(
	id INT NOT NULL PRIMARY KEY,
	person_id INT NOT NULL REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE,
	movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	person_role_id INT REFERENCES char_name(id) ON DELETE CASCADE ON UPDATE CASCADE,
	note VARCHAR(550),
	role_id INT NOT NULL REFERENCES role_type(id)
);
copy cast_info from 'C:/Personal/Data/imdb/cast_info.csv' DELIMITER ',' HEADER CSV;


CREATE TABLE company_type(
	id INT NOT NULL PRIMARY KEY,
	kind VARCHAR(30) NOT NULL
);
copy company_type from 'C:/Personal/Data/imdb/company_type.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE movie_company(
	id INT NOT NULL PRIMARY KEY,
	movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE ON UPDATE CASCADE,
	company_type_id INT REFERENCES company_type(id) ON DELETE NO ACTION ON UPDATE CASCADE,
	note VARCHAR(250)
);
copy movie_company from 'C:/Personal/Data/imdb/movie_company.csv' DELIMITER ',' HEADER CSV;


CREATE TABLE movie_info(
	id INT NOT NULL PRIMARY KEY,
	movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	info_type_id INT REFERENCES info_type(id) ON DELETE NO ACTION ON UPDATE CASCADE,
	info VARCHAR(35200),
	note VARCHAR(35200)
);
copy movie_info from 'C:/Personal/Data/imdb/movie_info.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE complete_cast(
	id INT NOT NULL PRIMARY KEY,
	movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	subject_id INT NOT NULL REFERENCES comp_cast_type ON DELETE NO ACTION ON UPDATE CASCADE,
	status_id INT NOT NULL REFERENCES comp_cast_type ON DELETE NO ACTION ON UPDATE CASCADE
);
copy complete_cast from 'C:/Personal/Data/imdb/complete_cast.csv' DELIMITER ',' HEADER CSV;

CREATE TABLE  movie_keyword(
	id INT NOT NULL PRIMARY KEY,
	movie_id INT NOT NULL REFERENCES movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	keyword_id INT NOT NULL REFERENCES keyword(id) ON DELETE CASCADE ON UPDATE CASCADE
);
copy movie_keyword from 'C:/Personal/Data/imdb/movie_keyword.csv' DELIMITER ',' HEADER CSV;
