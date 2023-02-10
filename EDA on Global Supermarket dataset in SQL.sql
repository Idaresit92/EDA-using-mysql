-- Carrying out EDA on the Global Supermarket store orders
select * from [dbo].[Orders]
--we have 51,290 rows

--Checking for missing values
select * from [dbo].[Orders]
where [Row ID] is NULL
--Result shows none

select * from [dbo].[Orders]
where [Order ID] is NULL
--Result shos none

--Checking the count in the order table
select count (*) from [dbo].[Orders]

--I want to check if the orderid is the primary key 
select [Order ID], count (*)
from [dbo].[Orders]
group by [Order ID]
having count (*) > 1
--From above query result, we see that we have orderIDs with multiple transactions, so this cannot be a primary key.

--Checking if the row iD is the primary key
select [Row ID], count (*)
from [dbo].[Orders]
group by [Row ID]
having count (*) > 1
--From above query results, the row Id is unique to a transaction, hence it is the primary key.


--It is ideal that the shipping date is greater than the order date. If it is not, that means our data has errors which needs to be corrected. 
---I will be checking if the shipping date is lesser than the order date
select * from [dbo].[Orders]
where [Ship Date] < [Order Date]
-- The query output shows that ship date is les than order date for all the rows

--I will be checking the unique ship mode
select distinct [Ship Mode]
from [dbo].[Orders]
--We have 4 unique ship modes; First Class, Same day, Standard Class, Second Classs


select distinct [Category]
from [dbo].[Orders]
--We have 3 unique categories; Office Supplies, Furniture, Technology

select distinct [Sub-Category]
from [dbo].[Orders]
-- We have 17 unique subcategories

select distinct [Segment]
from [dbo].[Orders]
--We have 3 unique segments; Corporate, Home Office, Consumer

select distinct [Region]
from [dbo].[Orders]
--We have 13 unique regions

select distinct [Country]
from [dbo].[Orders]
--We have a total of 47 unique countries

--Checking for the minumum and maximum number of days for each ship mode
select MIN (a.NumofDays), MAX(a.NumofDays)
from(
select DATEDIFF(Day, [Order Date], [Ship Date])
as NumofDays
from [dbo].[Orders]
where [Ship Mode] = 'Second Class')a
--The query result shows the minumum no of days is 2 and the maximum no of days is 5

select MIN (a.NumofDays), MAX(a.NumofDays)
from(
select DATEDIFF(Day, [Order Date], [Ship Date])
as NumofDays
from [dbo].[Orders]
where [Ship Mode] = 'First Class')a
--The query result shows the minumum no of days is 1 and the maximum no of days is 3


select MIN (a.NumofDays), MAX(a.NumofDays)
from(
select DATEDIFF(Day, [Order Date], [Ship Date])
as NumofDays
from [dbo].[Orders]
where [Ship Mode] = 'Standard Class')a
--The query result shows the minumum no of days is 4 and the maximum no of days is 7

select MIN (a.NumofDays), MAX(a.NumofDays)
from(
select DATEDIFF(Day, [Order Date], [Ship Date])
as NumofDays
from [dbo].[Orders]
where [Ship Mode] = 'Same Day')a
--The query result shows the minumum no of days is 0 and the maximum no of days is 1

--I will be checking the no of orders a customer has made 
select [Customer ID], [Order ID], count (*)
from [dbo].[Orders]
group by [Customer ID], [Order ID]
order by [Customer ID]
-- The query result shows the maximum order made by a custome is 8 and the inumum number is 1

