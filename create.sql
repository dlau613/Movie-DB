
create table Movie(id int primary key, title varchar(100), year int, rating varchar(10), company varchar(50));

create table Actor(id int primary key, last varchar(20), first varchar(20), sex varchar(6), dob date, dod date);

create table Director(id int primary key, last varchar(20), first varchar(20), dob date, dod date);

create table MovieGenre(mid int , genre varchar(20));

-- assuming movies can only have one credited director
create table MovieDirector(mid int primary key, did int,);

create table MovieActor(mid int, aid int, role varchar(50),primary key(mid,aid));

create table Review(name varchar(20), time timestamp, mid int, rating int, comment varchar(500));

create table MaxPersonID(id int primary key);

create table MaxMovieID(id int primary key);



