##                                          IPL2023 MATCHES PROJECT

/*

IPL2023_Matches is a MySQL-based mini-project simulating a cricket environment. 
It contains key modules like Teams,Venue,player,Matches,Umpire and Trainer. 
The purpose of this project is to showcase real-world data management and advanced SQL operations 
such as joins, indexing, triggers, ranking functions, views, and data cleaning using NULL handling.
*/

create database ipl2023_matches;
use  ipl2023_matches;

SET SQL_SAFE_UPDATES=1;

create table team(
				  team_id int primary key,
				  team_name char(50) not null,
                  team_owner varchar(60),
                  team_value varchar(70)
);

insert into Team (team_id, team_name, team_owner, team_value) 
values
(1, "Chennai Super Kings", "India Cements (N. Srinivasan)", "₹7,600 Crore"),
(2, "Mumbai Indians", "Reliance Industries (Mukesh Ambani)", "₹8,000 Crore"),
(3, "Gujarat Titans", "CVC Capital Partners", "₹7,300 Crore"),
(4, "Royal Challengers Bangalore", "United Spirits Limited", "₹7,200 Crore"),
(5, "Kolkata Knight Riders", "Red Chillies Entertainment (Shah Rukh Khan, Juhi Chawla)", "₹7,100 Crore");

select*from Team;

create table venue (
                     venue_id int primary key,
                     venue_name char(40),
                     city varchar(60),
                     capacity int
                     
);

insert into  Venue (venue_id, venue_name, city, capacity)
values
(101, "Wankhede Stadium", "Mumbai", 100000),
(102, "Narendra Modi Stadium", "Ahmedabad", 132000),
(103, "M. Chinnaswamy Stadium", "Bangalore", 60000),
(104, "Eden Gardens", "Kolkata", 68000),
(105, "MA Chidambaram Stadium", "Chennai", 50000);

create table Player(
					 player_id int primary key,
					 team_id int,
					 player_name char(50),
					 role varchar(60),
					 Foreign key(team_id) references team(team_id)
);

                          
insert into Player (player_id, player_name, role, team_id)
values
(1007, "MS Dhoni", "Wicketkeeper-Batsman", 1),
(1986, "Rohit Sharma", "Batsman", 2),
(8790, "Hardik Pandya", "All-Rounder", 3),
(1018, "Virat Kohli", "Batsman", 4),
(1098, "Andre Russell", "All-Rounder", 5);

select*from player;

CREATE TABLE Matches(
    match_id INT PRIMARY KEY,
    match_date DATE,
    venue_id INT,
    venue VARCHAR(100),
    team1 VARCHAR(40) NOT NULL,
    team2 VARCHAR(60) NOT NULL,
    player_of_the_match VARCHAR(50),--  e.g. runs 93 "Ruturaj Gaikwad"
    FOREIGN KEY(venue_id) REFERENCES venue(venue_id),
    Index (player_of_the_match)
    
);


insert into Matches (match_id, match_date, venue_id, venue, team1, team2, player_of_the_match) 
values
(1, "2023-03-31", 101, "Narendra Modi Stadium", "Gujarat Titans", "Chennai Super Kings", "Ruturaj Gaikwad"),
(2, "2023-04-01", 102, "Punjab Cricket Association IS Bindra Stadium", "Punjab Kings", "Kolkata Knight Riders", NULL),
(3, "2023-04-02", 103, NULL, "Delhi Capitals", "Lucknow Super Giants", "Mark Wood"),
(4, "2023-04-03", 104, NULL, "Mumbai Indians", "Royal Challengers Bangalore", NULL),
(5, "2023-04-04", 105, "Rajiv Gandhi International Stadium", "Sunrisers Hyderabad", "Rajasthan Royals", "Jos Buttler");


select*from Matches;

Create table  Umpire (
    umpire_id int primary key,
    umpire_name varchar(50) not null,
    country varchar(40),
    match_id int,
    foreign key (match_id) references Matches(match_id),
    Index(country)
);
 Insert into Umpire (umpire_id, umpire_name, country, match_id) 
 Values
(1, "Nitin Menon", "India", 1),
(2, "Chris Gaffaney", "New Zealand", 1),
(3, "Anil Chaudhary", NULL, 2),
(4, "Michael Gough", "England", NULL),
(5, "KN Ananthapadmanabhan", "India", 3);

Create table Trainer(
                    Trainer_id int primary key,
                    Trainer_name varchar(50) not null,
                    team_name varchar(40),
                    team_id int,
                    Specialization varchar(60),
                    foreign key(team_id) references Team(team_id),
                    Index(Specialization)
                    
);


Insert into Trainer (Trainer_id,Trainer_name,team_name,team_id,Specialization)
Values
(1, "Greg King","Chennai super kings",2,Null),
(2, "Rajinikanth Sivagnanam","Royal challengers bangalore",1,"Fitness"),
(3, "Paul Chapman","delhi capitals",3, "Performance Analyst"),
(4, "Shravan Kumar","gujarat titans",5,NULL),
(5, "Andrew Leipus","Mumbai indians",4,"Head Trainer");


/*
1. List all team names and their owners.
2. Show the venues located in Mumbai or Chennai.
3. Find all players and the team they belong to.
4. Show all matches with their venue names.
5. Find all matches where player_of_the_match is NULL.
6. Count how many matches each team has played as team1.
7. Show the top 3 venues with the largest capacity.
8.Find all umpires from India.
9. Show the trainer names along with the teams they train.
10. Display all trainers who do not have a specialization.
11. List all matches with umpire names (include matches with no umpires assigned).
12. Get the total seating capacity for all stadiums combined.
13. Find the match where 'Ruturaj Gaikwad' was player of the match.
14. Show all players whose role is 'All-Rounder'.
15. Find the number of players in each team.
16. List the teams in descending order of their valuation.
17. Find matches where venue name is missing (NULL).
18. Create a view showing match details with venue city.
19. Rank teams by valuation (highest first).
20. Show the count of umpires assigned to each match.
*/

-- 1. List all team names and their owners. --

SELECT team_name, team_owner 
FROM team;

-- 2. Show the venues located in Mumbai or Chennai.--

SELECT venue_name, city 
FROM venue 
WHERE city IN ('Mumbai', 'Chennai');

-- 3. Find all players and the team they belong to.--

SELECT p.player_name, t.team_name
FROM player p
JOIN team t ON p.team_id = t.team_id;

-- 4. Show all matches with their venue names.--

SELECT m.match_id, m.match_date, v.venue_name, m.team1, m.team2
FROM matches m
LEFT JOIN venue v ON m.venue_id = v.venue_id;

-- 5. Find all matches where player_of_the_match is NULL.--

SELECT match_id, match_date, team1, team2
FROM matches
WHERE player_of_the_match IS NULL;

-- 6. Count how many matches each team has played as team1.--

SELECT team1 AS team_name, COUNT(*) AS matches_played
FROM matches
GROUP BY team1;

-- 7. Show the top 3 venues with the largest capacity.--

SELECT venue_name, capacity
FROM venue
ORDER BY capacity DESC
LIMIT 3;

-- 8. Find all umpires from India.--

SELECT umpire_name, country
FROM umpire
WHERE country = 'India';

-- 9. Show the trainer names along with the teams they train.--

SELECT trainer_name, team_name, specialization
FROM trainer;

-- 10. Display all trainers who do not have a specialization.--

SELECT trainer_name, team_name
FROM trainer
WHERE specialization IS NULL;

-- 11. List all matches with umpire names (include matches with no umpires assigned).--

SELECT m.match_id, m.match_date, u.umpire_name
FROM matches m
LEFT JOIN umpire u ON m.match_id = u.match_id;

-- 12. Get the total seating capacity for all stadiums combined.--

SELECT SUM(capacity) AS total_capacity
FROM venue;

-- 13. Find the match where 'Ruturaj Gaikwad' was player of the match.--

SELECT match_id, match_date, team1, team2
FROM matches
WHERE player_of_the_match = 'Ruturaj Gaikwad';

-- 14. Show all players whose role is 'All-Rounder'.--

SELECT player_name, team_id
FROM player
WHERE role = 'All-Rounder';

-- 15. Find the number of players in each team.--

SELECT t.team_name, COUNT(p.player_id) AS player_count
FROM team t
LEFT JOIN player p ON t.team_id = p.team_id
GROUP BY t.team_name;

-- 16. List the teams in descending order of their valuation.--

SELECT team_name, team_value
FROM team
ORDER BY CAST(REPLACE(REPLACE(team_value, '₹', ''), ' Crore', '') 
AS UNSIGNED) DESC;

-- 17. Find matches where venue name is missing (NULL).--

SELECT match_id, match_date, team1, team2
FROM matches
WHERE venue IS NULL;

-- 18. Create a view showing match details with venue city.--

CREATE VIEW match_with_city AS
SELECT m.match_id, m.match_date, m.team1, m.team2, v.city
FROM matches m
LEFT JOIN venue v ON m.venue_id = v.venue_id;

-- 19. Rank teams by valuation (highest first).--

SELECT team_name, team_value,
       RANK() OVER (ORDER BY CAST(REPLACE(REPLACE(team_value, '₹', ''), ' Crore', '') AS UNSIGNED) DESC)
       AS rank_position
       FROM team;
       
-- 20. Show the count of umpires assigned to each match.--

SELECT match_id, COUNT(umpire_id) AS umpire_count
FROM umpire
GROUP BY match_id;
