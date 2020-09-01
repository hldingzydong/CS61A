.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = "blue" AND pet = "dog";

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = "blue" AND pet = "dog";


CREATE TABLE matchmaker AS
  SELECT t1.pet, t1.song, t1.color, t2.color FROM students AS t1, students AS t2 WHERE t1.pet = t2.pet
  AND t1.song = t2.song AND t1.time < t2.time;


CREATE TABLE sevens AS
  SELECT students.seven FROM students, numbers WHERE students.number = 7 AND numbers.'7' = 'True' AND students.time = numbers.time;


CREATE TABLE favpets AS
  SELECT students.pet, COUNT(*) FROM students GROUP BY students.pet ORDER BY COUNT(*) DESC LIMIT 10;


CREATE TABLE dog AS
  SELECT students.pet, COUNT(*) FROM students WHERE students.pet = 'dog';


CREATE TABLE bluedog_agg AS
  SELECT bluedog_songs.song, COUNT(*) FROM bluedog_songs GROUP BY bluedog_songs.song ORDER BY COUNT(*) DESC;


CREATE TABLE instructor_obedience AS
  SELECT seven, instructor, COUNT(*) FROM students WHERE seven = '7' GROUP BY instructor ORDER BY instructor;

