create database ecoomerce;

select * from blinkit_grocery;
select count(*) as total from blinkit_grocery;
select distinct ItemFat_Content from blinkit_grocery Order by ItemFat_Content;
# clean the data using conditional queries
select ItemFat_Content,
	CASE 
        WHEN (ItemFat_Content) in ( 'Low Fat', 'LF') THEN 'LOW FAT'
        WHEN (ItemFat_Content) in ( 'Regular', 'reg') THEN 'REGULAR'
        ELSE 'ItemFat'
    END AS FAT_CONTENT
 FROM blinkit_grocery;   
 
select distinct Item_Type from blinkit_grocery Order by Item_Type;
select distinct Outlet_Type from blinkit_grocery Order by Outlet_Type;

## Sales Analysis
-- Total and Ang sales by Item Type
select Item_Type,
       sum(Sales) as Total_Sales,
       AVG(Sales) as Avg_Sales,
       MAX(Sales) as Max_sales
 from blinkit_grocery
 group by Item_Type
 Order by Total_Sales DESC;
 
 -- Total and Ang sales by Outlet Type
 
 select Outlet_Type,
       sum(Sales) as Total_Sales,
       AVG(Sales) as Avg_Sales,
       MAX(Sales) as Max_sales
 from blinkit_grocery
 group by Outlet_Type
 Order by Total_Sales DESC;
 
 -- Top 10 Highest Selling Item
 
 select Item_Type Item_Identifier,
       sum(Sales) as Total_Sales
 from blinkit_grocery
 group by Item_Type
 Order by Total_Sales DESC
 Limit 10;
 
 -- Fat Content wise analysis
 select 
	CASE 
        WHEN (ItemFat_Content) in ( 'Low Fat', 'LF') THEN 'LOW FAT'
        WHEN (ItemFat_Content) in ( 'Regular', 'reg') THEN 'REGULAR'
        ELSE 'ItemFat'
    END AS FAT_CONTENT,
	Item_Type, Outlet_Type,
       sum(Sales) as Total_Sales,
       AVG(Sales) as Avg_Sales,
       count(*) as Item_Count
 from blinkit_grocery
 group by FAT_CONTENT, Item_Type, Outlet_Type
 Order by Total_Sales DESC;
 
 -- Outlet Performance analysis
 select Outlet_Type, Outlet_size,
       sum(Sales) as Total_sales,
       count(*) as item_count
from blinkit_grocery
group by Outlet_Type , Outlet_Size
order by Total_sales Desc;

 select  Outlet_size, OutletEstablishment_Year,
       sum(Sales) as Total_sales,
       count(*) as item_count
from blinkit_grocery
group by Outlet_Size, OutletEstablishment_Year
order by Total_sales Desc;

CREATE VIEW item_type_performance AS
SELECT 
    Item_Type,
    COUNT(*) AS item_count,
    SUM(Sales) AS total_sales,
    AVG(Sales) AS avg_sales,
    AVG(Rating) AS avg_rating
FROM blinkit_grocery
GROUP BY Item_Type;

-- Average rating by outlet type
SELECT 
    Outlet_Type,
    AVG("Rating") AS avg_rating,
    COUNT(*) AS item_count
FROM blinkit_grocery
GROUP BY Outlet_Type
ORDER BY avg_rating DESC;

-- Items with below average ratings (subquery example)
SELECT 
    Item_Identifier,
    Item_Type,
    Rating
FROM blinkit_grocery
WHERE Rating < (SELECT AVG("Rating") FROM blinkit_grocery)
ORDER BY Rating ASC
LIMIT 10;

-- Compare sales of low fat vs regular items within each outlet type
