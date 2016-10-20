-- violate primary key constraint for Movie by adding a movie with an id that already exists
-- movie with id 264 already exsists
-- ERROR 1062 (23000): Duplicate entry '264' for key 'PRIMARY'
insert into Movie values(264, "best movie", 2016, "PG","Daniel's Production Company");

-- violate primary key constraint for Actor
-- actor with id 5610 already exists
-- ERROR 1062 (23000): Duplicate entry '5610' for key 'PRIMARY'
insert into Actor values(5610,"Lau","Daniel","male",19940613,null);

-- violate primary key constraint for Director
-- director with id 68626 already exists
-- ERROR 1062 (23000): Duplicate entry '68626' for key 'PRIMARY'
insert into Director values(68626,"Lau","Daniel",19940613,null);

-- violate primary key constraint for MovieGenre
-- tuple with mid,genre = 97,Drama already exists
-- ERROR 1062 (23000): Duplicate entry '97-Drama' for key 'PRIMARY'
insert into MovieGenre values(97,"Drama");

-- violate primary key constraint for MovieDirector
-- tuple with mid,did = 9,13699 already exists
-- ERROR 1062 (23000): Duplicate entry '9-13699' for key 'PRIMARY'
insert into MovieDirector values(9,13699);

-- violate primary key constraint for MovieActor
-- tuple with mid,aid = 264,5610,"Nisi" already exists
-- ERROR 1062 (23000): Duplicate entry '264-5610-Nisi' for key 'PRIMARY'
insert into MovieActor values(264,5610,"Nisi");

-- violate MovieGenre id foreign key constraint on Movie(id)
-- doesn't exist Movie where id=1 so we can't add a MovieGenre with that id
-- ERROR 1452 (23000): CANNOT ADD OR UPDATE A CHILD ROW: A FOREIGN KEY CONSTRAINT FAILS
-- ('TEST'.'MovieGenre', CONSTRAINT 'MovieGenre_ibfk_1' FOREIGN KEY ('mid') REFERENCES 'Movie' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
insert into MovieGenre values(1,"Drama");

-- violate MovieGenre id foreign key constraint on Movie(id) by deleting the Movie with id,
-- but DB fixes the violation by cascading and deleting tuples in MovieGenre with the same mid
-- this statment works because fixes violation
delete from Movie where id=263;

-- violate MovieDirector mid foreign key constraint on Movie(id)
-- and did foreign key constraint on Director(id)
-- no Movie where id=1 and no director where id=9
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- ('TEST'.'MovieDirector', CONSTRAINT 'MovieDirector_ibfk_1' FOREIGN KEY ('mid') REFERENCES 'Movie' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
insert into MovieDirector values(1,13699);

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- ('TEST'.'MovieDirector', CONSTRAINT 'MovieDirector_ibfk_1' FOREIGN KEY ('did') REFERENCES 'Director' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
insert into MovieDirector values(264,9);

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- ('TEST'.'MovieDirector', CONSTRAINT 'MovieDirector_ibfk_1' FOREIGN KEY ('mid') REFERENCES 'Movie' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
update MovieDirector set mid=1 where mid=38;


-- violate MovieActor mid foreign key constraint on Movie(id)
-- and aid foreign key constraint on Actor(id)
-- no movie where id=1 and no movie where aid=2

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- ('TEST'.'MovieActor', CONSTRAINT 'MovieActor_ibfk_1' FOREIGN KEY ('mid') REFERENCES 'Movie' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
insert into MovieActor values(1,5610,"herself");

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- ('TEST'.'MovieActor', CONSTRAINT 'MovieActor_ibfk_1' FOREIGN KEY ('aid') REFERENCES 'Actor' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
insert into MovieActor values(264,2,"daniel");

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- ('TEST'.'MovieActor', CONSTRAINT 'MovieActor_ibfk_1' FOREIGN KEY ('aid') REFERENCES 'Actor' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
update MovieActor set aid=2 where aid=5610;

-- violate Review mid foregin key constraint on Movie(id)
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- ('TEST'.'Review', CONSTRAINT 'Review_ibfk_1' FOREIGN KEY ('mid') REFERENCES 'Movie' ('id')
-- ON DELETE CASCADE ON UPDATE CASCADE)
insert into Review values("Daniel Lau", NOW(),1,4,"so good");


-- statements below will actually work because doesn't actually check

-- violate check constraint on Review rating. rating should be between 0 and 5
-- insert into Review values("Daniel Lau", NOW(),2,5,"amazing");
-- update Review set rating=6 where mid=2;


-- violate check constraint that actor id isn't negative
-- update Actor set id=-10 where id=5610;

-- violate check constraint that sex must be Male or Female
-- update Actor set sex="F" where id=5610;

-- violate check constraint that movie id isn't negative
-- update Movie set id=-100 where id=264;

-- violate check constraint that director id isn't negative
-- update Director set id=-1000 where id=13699;

