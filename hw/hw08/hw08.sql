CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dogs.name, sizes.size FROM dogs, sizes WHERE dogs.height > sizes.min AND dogs.height <= sizes.max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT t1.name FROM parents, dogs AS t1, dogs AS t2 WHERE parents.child = t1.name AND parents.parent = t2.name ORDER BY t2.height DESC;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT t1.name AS bro, t2.name AS lbro , size FROM dogs AS t1, dogs AS t2, sizes WHERE t1.height > sizes.min
  AND t1.height <= sizes.max AND t2.height > sizes.min AND t2.height <= sizes.max AND t1.name < t2.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT bro || " and " || lbro || " are " || size || " siblings" FROM siblings, parents AS p1, parents AS p2
  WHERE bro = p1.child AND lbro = p2.child AND p1.parent = p2.parent;


-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height, n);

INSERT INTO stacks_helper SELECT dogs.name, dogs.height, dogs.height, 1 FROM dogs;

INSERT INTO stacks_helper(dogs, stack_height, last_height, n)
SELECT t1.dogs || ", " || t2.dogs, t1.stack_height + t2.stack_height, t2.last_height, 2
FROM stacks_helper AS t1, stacks_helper AS t2 WHERE t1.last_height < t2.last_height;

INSERT INTO stacks_helper(dogs, stack_height, last_height, n)
SELECT t1.dogs || ", " || t2.dogs, t1.stack_height + t2.stack_height, t2.last_height, 3
FROM stacks_helper AS t1, stacks_helper AS t2 WHERE t1.last_height < t2.last_height AND t1.n = 2 AND t2.n = 1;

INSERT INTO stacks_helper(dogs, stack_height, last_height, n)
SELECT t1.dogs || ", " || t2.dogs, t1.stack_height + t2.stack_height, t2.last_height, 4
FROM stacks_helper AS t1, stacks_helper AS t2 WHERE t1.last_height < t2.last_height AND t1.n = 3 AND t2.n = 1;

CREATE TABLE stacks AS
  SELECT stacks_helper.dogs, stacks_helper.stack_height FROM stacks_helper
  WHERE stacks_helper.stack_height > 170 AND stacks_helper.n = 4
  ORDER BY stacks_helper.stack_height;


