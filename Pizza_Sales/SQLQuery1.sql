SELECT
    pizza_category,
    SUM(total_price) AS Total_Sales,
    SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT

FROM 
    pizza_sales
--WHERE MONTH(order_date) = 1
GROUP BY
    pizza_category --result is difference as veggie .

select *
from pizza_sales

--A
--1. Total Revenue:
--The sum of the total price of all pizza orders
--(Tüm pizza sipariþlerinin toplam fiyatý)
select total_price
from pizza_sales
--
SELECT SUM(total_price)  AS Total_Revenue
FROM pizza_sales
--sonuçlar küsüratta farklý çýktý.


--2. Average Order Value:
--The avarage amount spent per order,calculated by dividing the total revenue by the total number of orders.
--(Toplam gelirin toplam sipariþ sayýsýna bölünmesiyle hesaplanan, sipariþ baþýna harcanan ortalama tutar.)
SELECT SUM(total_price)  FROM pizza_sales

SELECT MAX(DISTINCT order_id ) FROM pizza_sales

SELECT  COUNT(order_id)  FROM pizza_sales

SELECT  COUNT(DISTINCT order_id) FROM pizza_sales

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales


--3. Total Pizzas Sold:
--the sum of the quantities of all pizzas sold.(satýlan tüm pizzalarýn miktarlarýnýn toplamý)
SELECT SUM(quantity) AS Total_Pizza_Sold  
FROM pizza_sales



select pizza_category, SUM(quantity) as total_pizza_sold_by_category from pizza_sales group by pizza_category
--satýlan tüm pizzalarýn çeside göre toplamlarý


--4. Total Orders:
--The total number of orders placed.(Verilen toplam sipariþ sayýsý)
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales

SELECT pizza_category, COUNT(DISTINCT order_id) AS Total_Orders_by_category 
FROM pizza_sales 
group by pizza_category


--5. Avarage Pizzas Per Order:
--the avarage number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of order.
--(ortalama olarak her sipariþte kaç pizza sattýðýný hesaplamak)
SELECT * FROM pizza_sales
--(SELECT CAST(12 AS DECIMAL(5,2) ) AS decimal_value;-- integer bir veriyi 5 karakter yer ayýrýp ve virgülden sonra 2 karakter yazýp decimal'e çevirdi)


SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Avg_Pizzas_per_order FROM pizza_sales

SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2) ) FROM pizza_sales


SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))AS Avg_Pizzas_per_order
FROM pizza_sales
--CAST iþlevi, verilerin türünü belirli bir biçime dönüþtürmek için kullanýlýr ve bu sorguda, 
--sayýsal sonuçlarýn ondalýk bir tipe ve belirli bir hassasiyete sahip olmasýný saðlamak için kullanýlmýþtýr. 
--"DECIMAL(10,2)" veri türü: Bu, ondalýk sayýlarýn 10 basamaklý olacaðýný ve virgülden sonra 2 basamaklý hassasiyetle gösterileceðini belirtir.
--mylinear
select sum (quantity ),count(distinct order_id), cast(sum (quantity )*0.1/count(distinct order_id) as decimal(10,2))
from pizza_sales



--B. Hourly Trend for Total Pizzas Sold(Satýlan Toplam Pizza Ýçin Saatlik Trend)
--(create a stacked bar chart that displays the hourly trend of total orders over a specific time period. )
--(belirli bir zaman dilimi boyunca toplam sipariþlerin saatlik eðilimini gösteren yýðýlmýþ bir çubuk grafik oluþturun.)
--(This chart will help us identify any patterns or fluctuations in order volumes on a hourly basis.)
--(Bu grafik, sipariþ hacimlerindeki saatlik bazda herhangi bir modeli veya dalgalanmayý tespit etmemize yardýmcý olacaktýr.)
SELECT *
FROM pizza_sales
                      
SELECT DATEPART(HOUR, order_time) as order_hours, SUM(quantity) as total_pizzas_sold --DATEPARt returns the value of a specific part of the date in integer format
FROM pizza_sales                                                                      --Syntax : DATEPART(interval, date)
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)


--C. Weekly Trend For Total Orders(Toplam Sipariþlerde Haftalýk Trend)
--create a line chart that illustrates the weekly trend of total orders throughout the year.
--(Yýl boyunca toplam sipariþlerin haftalýk eðilimini gösteren bir çizgi grafik oluþturun.)
--this chart will help us to identify peak weeks or periods og high order activity
--(bu grafik, yoðun haftalarý veya yüksek düzeyde faaliyet dönemlerini belirlememize yardýmcý olacaktýr.)

SELECT 
    DATEPART(ISO_WEEK, order_date) AS WeekNumber,
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders,
	SUM(quantity) as total_pizzas_sold
FROM 
    pizza_sales
GROUP BY 
    DATEPART(ISO_WEEK, order_date),
    YEAR(order_date)
ORDER BY 
    Year, WeekNumber;


--D. Percentage of Sales by Pizza Category

SELECT pizza_category,SUM(total_price)*100
FROM pizza_sales
GROUP BY pizza_category

--küsüratlý hali
SELECT pizza_category, SUM(total_price)  as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category

-- select only mounth of january
SELECT pizza_category, SUM(total_price)  as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) =1 
GROUP BY pizza_category

--select only first quarter of years
SELECT pizza_category, SUM(total_price)  as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) =1 -- tarihin 1. çeyrekte olduðu sorgularý getirir.
GROUP BY pizza_category

--
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category


--E.  Percentage of Sales by Pizza Size
select pizza_size,SUM(total_price) 
from pizza_sales
GROUP BY pizza_size

--küsüratlý hali
SELECT pizza_size, SUM(total_price)  as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_size

-- select only mounth of february
SELECT pizza_size, SUM(total_price)  as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) =1 
GROUP BY pizza_size
ORDER BY PCT DESC

--select only first quarter of years
SELECT pizza_size, SUM(total_price)  as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) =1
GROUP BY pizza_size
ORDER BY PCT DESC

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(total_price)as total_revenue,SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--G. Top 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--H. Bottom 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC



--I. Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC


--J. Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--Top 5 pizzas by orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC


--bottom 5 pizzas by orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC