

-- Sales comparision monthwise between 2022 and 2023
SELECT 
	a.month_name,
	a.sales_2022,
	a.sales_2023,
	CASE 
		WHEN a.sales_2023 = 0 THEN 0 
		ELSE CAST((a.sales_2023 - a.sales_2022) / a.sales_2022 * 100 AS DECIMAL(5,2)) END AS mom_increase
FROM 
	(SELECT 
		DATEPART(MONTH, Date) month,
		DATENAME(MONTH, Date) month_name,
		SUM(CASE WHEN YEAR(Date) = 2022 THEN Product_Price * Units ELSE 0 END) sales_2022, 
		SUM(CASE WHEN YEAR(Date) = 2023 THEN Product_Price * Units ELSE 0 END) sales_2023
	FROM Toys
	GROUP BY DATEPART(MONTH, Date), DATENAME(MONTH, Date)) a
ORDER BY a.month;

-- Profit comparision monthwise between 2022 ansd 2023
SELECT
	a.month_name,
	a.profit_2022,
	a.profit_2023,
	CASE WHEN a.profit_2023 = 0 THEN 0 ELSE
		CAST((a.profit_2023 -a.profit_2022) / a.profit_2022 * 100 AS DECIMAL(5,2)) END AS mom_profit
FROM
	(SELECT 
		DATEPART(MONTH, Date) month_no,
		DATENAME(MONTH, Date) month_name,
		SUM(CASE WHEN DATEPART(YEAR, Date) = 2022 THEN (Product_Price - Product_Cost) * Units ELSE 0 END) AS profit_2022,
		SUM(CASE WHEN DATEPART(YEAR, Date) = 2023 THEN (Product_Price - Product_Cost) * Units ELSE 0 END) AS profit_2023
	FROM Toys
	GROUP BY DATEPART(MONTH, Date), DATENAME(MONTH, Date)) a
ORDER BY a.month_no;

-- Games Category sales monthwise 
SELECT 
	a.month_name,
	a.games_sales_2022,
	a.games_sales_2023,
	CASE WHEN a.games_sales_2023 = 0 THEN 0 ELSE 
	CAST((a.games_sales_2023 - a.games_sales_2022) / a.games_sales_2022 * 100 AS DECIMAL(5,2)) END mom_games
FROM
		(SELECT 
			DATEPART(MONTH, Date) month_no,
			DATENAME(MONTH, Date) month_name,
			SUM(CASE WHEN DATEPART(YEAR, Date) = 2022 THEN Product_Price * Units ELSE 0 END) AS games_sales_2022,
			SUM(CASE WHEN DATEPART(YEAR, Date) = 2023 THEN Product_Price * Units ELSE 0 END) AS games_sales_2023
		FROM Toys
		WHERE Product_Category = 'Games'
		GROUP BY DATEPART(MONTH, Date), DATENAME(MONTH, Date))a
ORDER BY a.month_no

-- Sports & Outdoors monthwise sales comparision
SELECT 
	a.month_name,
	a.SO_sales_2022,
	a.SO_sales_2023,
	CASE WHEN a.SO_sales_2023 = 0 THEN 0 ELSE 
	CAST((a.SO_sales_2023 - a.SO_sales_2022) / a.SO_sales_2022 * 100 AS DECIMAL(5,2)) END mom_games
FROM
		(SELECT 
			DATEPART(MONTH, Date) month_no,
			DATENAME(MONTH, Date) month_name,
			SUM(CASE WHEN DATEPART(YEAR, Date) = 2022 THEN Product_Price * Units ELSE 0 END) AS SO_sales_2022,
			SUM(CASE WHEN DATEPART(YEAR, Date) = 2023 THEN Product_Price * Units ELSE 0 END) AS SO_sales_2023
		FROM Toys
		WHERE Product_Category = 'Sports & Outdoors'
		GROUP BY DATEPART(MONTH, Date), DATENAME(MONTH, Date))a
ORDER BY a.month_no

-- Toys monthwise sales comparision
SELECT 
	a.month_name,
	a.toys_2022,
	a.toys_2023,
	CASE WHEN a.toys_2023 = 0 THEN 0 ELSE 
	CAST((a.toys_2023 - a.toys_2022) / a.toys_2022 * 100 AS DECIMAL(5,2)) END mom_games
FROM
		(SELECT 
			DATEPART(MONTH, Date) month_no,
			DATENAME(MONTH, Date) month_name,
			SUM(CASE WHEN DATEPART(YEAR, Date) = 2022 THEN Product_Price * Units ELSE 0 END) AS toys_2022,
			SUM(CASE WHEN DATEPART(YEAR, Date) = 2023 THEN Product_Price * Units ELSE 0 END) AS toys_2023
		FROM Toys
		WHERE Product_Category = 'Toys'
		GROUP BY DATEPART(MONTH, Date), DATENAME(MONTH, Date))a
ORDER BY a.month_no;

-- Total Orders
SELECT 
	a.month_name,
	a.orders_2022,
	a.orders_2023,
	CASE WHEN a.orders_2023 = 0 THEN 0 ELSE CAST((CAST(a.orders_2023 AS DECIMAL(7,2)) - a.orders_2022) / a.orders_2022 * 100 AS DECIMAL(7,2)) END AS mom_orders
FROM
	(SELECT 
		DATEPART(MONTH, Date) month_no,
		DATENAME(MONTH, Date) month_name,
		COUNT(CASE WHEN DATEPART(YEAR, Date) = 2022 THEN Sale_ID END) AS orders_2022,
		COUNT(CASE WHEN DATEPART(YEAR, Date) = 2023 THEN Sale_ID END) AS orders_2023
	FROM Toys
	GROUP BY DATEPART(MONTH, Date), DATENAME(MONTH, Date)) a
ORDER BY a.month_no;

SELECT 
	Store_Name,
	SUM(Product_Cost * Stock_On_Hand) inventory_value,
	SUM(Product_Price * Units) sales_values
FROM Toys
GROUP BY Store_Name;

