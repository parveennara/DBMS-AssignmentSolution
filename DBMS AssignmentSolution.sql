drop database if exists TravelOnTheGo;

Create database TravelOnTheGo;

use TravelOnTheGo;

create table Passenger(Passenger_name varchar (100),
Category varchar (10),
Gender varchar (10),
Boarding_City varchar (100),
Destination_City varchar (100),
Distance int,
Bus_Type varchar(10)
);

create table Price(
Bus_Type varchar(10),
Distance int,
Price int
);

insert into Passenger values ("Sejal", "AC", "F", "Bengaluru", "Chennai", "350", "Sleeper");
insert into Passenger values ("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", "700", "Sitting");
insert into Passenger values ("Pallavi", "AC", "F", "Panaji", "Bengaluru", "600", "Sleeper");
insert into Passenger values ("Khusboo", "AC", "F", "Chennai", "Mumbai", "1500", "Sleeper");
insert into Passenger values ("Udit", "Non-AC", "M", "Trivandrum", "panaji", "1000", "Sleeper");
insert into Passenger values ("Ankur", "AC", "M", "Nagpur", "Hyderabad", "500", "Sitting");
insert into Passenger values ("Hemant", "Non-AC", "M", "panaji", "Mumbai", "700", "Sleeper");
insert into Passenger values ("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", "500", "Sitting");
insert into Passenger values ("Piyush", "AC", "M", "Pune", "Nagpur", "700", "Sitting");

insert into Price values ("Sleeper", "350", "770");
insert into Price values ("Sleeper", "500", "1100");
insert into Price values ("Sleeper", "600", "1320");
insert into Price values ("Sleeper", "700", "1540");
insert into Price values ("Sleeper", "1000", "2200");
insert into Price values ("Sleeper", "1200", "2640");
insert into Price values ("Sleeper", "350", "434");
insert into Price values ("Sitting", "500", "620");
insert into Price values ("Sitting", "500", "620");
insert into Price values ("Sitting", "600", "744");
insert into Price values ("Sitting", "700", "868");
insert into Price values ("Sitting", "1000", "1240");
insert into Price values ("Sitting", "1200", "1488");
insert into Price values ("Sitting", "1500", "1860");

/*
How many females and how many male passengers travelled for a minimum distance of
600 KM s?
*/

select Gender, count(Gender) as `Number of Passengers` from Passenger where Distance>=600 group by Gender;

/*
Find the minimum ticket price for Sleeper Bus.
*/

select min(Price) as `Lowest Price` from Price where Bus_Type="Sleeper";

/*
Select passenger names whose names start with character 'S'
*/

select Passenger_Name from Passenger where Passenger_Name like 'S%';

/*
Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output
*/

select Passenger.Passenger_Name, Passenger.Boarding_City, Passenger.Destination_City, Passenger.Bus_Type, Price from Passenger
left join Price on Passenger.Bus_Type=Price.Bus_Type where Passenger.Distance=Price.Distance;

/*
What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s
*/

select Passenger_Name, Price from Passenger join Price 
on Passenger.Distance=Price.Distance and Passenger.Bus_Type=Price.Bus_Type 
where Passenger.Bus_Type="Sitting" and Passenger.Distance=1000;

/*
What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?
*/

select Bus_Type, Price from Price 
where Distance=(select Distance from Passenger where ((Boarding_City="Bengaluru" and Destination_city="Panaji") 
or (Boarding_City="Panaji" and Destination_City="Bengaluru")));

/*
List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.
*/

select distinct Distance from Passenger order by Distance desc;

/*
Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables
*/

select Passenger_Name, Distance*100/(select sum(Distance) from Passenger)as `percentage of distance travelled` from Passenger;

/*
Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/

select Distance, Price,
case
	when Price>1000 then "Expensive"
    when Price>500 then "Average Cost"
    else "Cheap"
end
as Price_Rating from Price;
