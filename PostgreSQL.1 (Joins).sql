--SQL JOINS

  CREATE TABLE playlist (
  artist VARCHAR,
  song VARCHAR);
  
  CREATE TABLE toplist (
  tophit VARCHAR,
  play INT);
  
  INSERT INTO playlist (artist,song) VALUES
  ('ABBA','Dancing Queen'),
  ('ABBA','Gimme!'),
  ('ABBA','The Winner Takes It All'),
  ('ABBA','Mamma Mia'),
  ('ABBA','Take a Chance On Me'),
  
  INSERT INTO toplist (tophit,play) VALUES
  ('Dancing Queen',95145796),
  ('Gimme!',32785696),
  ('The Winner Takes It All',34458597),
  ('Mamma Mia',47901900),
  ('Take a Chance On Me',30654536),
  ('Cool Girl',227055115),
  ('Stay High',263901766),
  ('Talking Body',272334711),
  ('Habits',214685822),
  ('True Disaster',27028538),
  ('Wake Me Up',520259542),
  ('Waiting For Love',399906192),
  ('The Nights',278063930),
  ('Hey Brother',321270703),
  ('Levels',206004691),
  ('Despacito',519689490);
  ('Tove Lo','Cool Girl'),
  ('Tove Lo','Stay High'),
  ('Tove Lo','Talking Body'),
  ('Tove Lo','Habits'),
  ('Tove Lo','True Disaster'),
  ('Avicii','Wake Me Up'),
  ('Avicii','Waiting For Love'),
  ('Avicii','The Nights'),
  ('Avicii','Hey Brother'),
  ('Avicii','Levels'),
  ('Zara Larsson','Lush Life');
  
  SELECT * FROM playlist;
  
  SELECT* FROM toplist;
  
  -- BASIC SQL JOIN 
  SELECT * 
  FROM playlist
  JOIN toplist
  ON song = tophit;
  
  --Dot notation with one column
  
  SELECT
  toplist.tophit,
  toplist.play,
  playlist.artist
FROM toplist
JOIN playlist
ON toplist.tophit = playlist.song;

--FULL JOIN to incorporate all rows
 SELECT
  toplist.tophit,
  toplist.play,
  playlist.artist
FROM toplist
FULL JOIN playlist
ON toplist.tophit = playlist.song;

-- FULL JOIN — but keeping the missing values only from one of the SQL tables

--LEFT JOIN
SELECT
  toplist.tophit,
  toplist.play,
  playlist.artist
FROM toplist
LEFT JOIN playlist
ON playlist.song= toplist.tophit;

-- Keeps every line from the toplist table (that’s the LEFT table) even if it
--doesn’t exist in the playlist table (which is the RIGHT table)

--RIGHT JOIN
SELECT
  toplist.tophit,
  toplist.play,
  playlist.artist
FROM toplist
RIGHT JOIN playlist
ON playlist.song= toplist.tophit;

--PRACTICE QUESTION
--Given the information in the playlist and toplist data tables:
--How many plays does each artist have in total?
SELECT playlist.artist, SUM(toplist.play)
from toplist
full join playlist
on playlist.song= toplist.tophit
group by artist;

--Print the top 5 ABBA songs ordered by number of plays
select playlist.song,SUM(toplist.play)as num_of_plays
FROM toplist
join playlist
on playlist.song= toplist.tophit
where artist = 'ABBA'
GROUP BY song
order by num_of_plays desc;
