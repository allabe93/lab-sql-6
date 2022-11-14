-- In this activity we are going to do some database maintenance. In the current database we only have information on movies for the year 2006. Now we have received the film catalog for 2020 as well. For this new data we will create another table and bulk insert all the data there. Code to create a new table has been provided below.

drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` int unsigned not null AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

-- We have just one item for each film, and all will be placed in the new table. For 2020, the rental duration will be 3 days, with an offer price of 2.99€ and a replacement cost of 8.99€ (these are all fixed values for all movies for this year). The catalog is in a CSV file named films_2020.csv that can be found at files_for_lab folder.

-- Add the new films to the database.
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/films_2020.csv' 
into table films_2020
fields terminated by ',';

show variables like 'local_infile';
set global local_infile = 1;

show variables like 'secure_file_priv'; -- this gives you the path you need to save the .csv to

set sql_safe_updates = 0;

-- I correctly created the table with the code provided in GitHub, however, I was having an error when loading the data both with the code that is above and also via Table Data Import Wizard ("Create new table"), so I had to use Table Data Import Wizard "creating a new table and not" "using existing table".
-- However, finally the table is in the database as one can reviw runnig the below code.
 
 select * from films_2020;

-- Update information on rental_duration, rental_rate, and replacement_cost.
update films_2020
set rental_duration = 3, rental_rate = 2.99 , replacement_cost = 8.99;

select * from films_2020;