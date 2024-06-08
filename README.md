# Maven-Toys-Analysis-Report

## Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning and Preparation](#data-cleaning-and-preparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Recommedations](#recommedations)
- [Results and findings](#results-and-findings)
- [Limitations](#limitations)
- [References](#references)

### Project Overview
This analysis project aims at analyzing intresting patterns and trends in the toy sales data provided to help the directors make informed descions for their planned expansion of the business with new stores.

![maven_toys](https://github.com/Joendege/Maven-Toys-Analysis-Report/assets/123901910/9b70f00e-8756-45f2-970d-27380c057537)


### Data Sources
The data sorces used for this analaysis are from four files:
- **"sales.csv"**
- **"stores.csv"**
- **"products.csv"**
- **"inventory.csv"**


### Tools
- Microsoft Excel - [Download Here](https://www.microsoft.com)
- MS SQL Server - [Download Here](https://www.microsoft.com)
- Power BI Desktop - [Download Here](https://www.microsoft.com)

### Data Cleaning and Preparation
In this phase I performed the following tasks:
- Data loading and Inspection
- Merging the four data tables
- Data Formatting
- Creating Data tables
- Creating DAX Measures and Calculated columns
- Data Modellimg

### Exploratory Data Analysis
EDA involved exploring the data to answer the following questions:
1. How does sales, profit and orders compare for the year 2022 and year 2023?
2. What is Month on Month Sales, Profit and Orders?
3. How is the performance of each store loaction in terms of Total Sales, Total Orders and Total Profit?
4. What is the monthly trend for the sales, profit and orders?


### Data Analysis

``` SQL
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
```
``` SQL

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

```
``` SQL

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
```

### Recommedations
1. Expand the business by opening  new  stores.
2. Market and promote Games and Sports & Outdoors categories.
3. Ensure that Toys categories are available to each and every store to maximise sales.

### Results and findings
The analysis results are summarized as follows:
1. There is a significant increase of Total Sales, Total Profit and Total Orders on montly basis in comparision fro the two years
2. There is a positive performance of Month on Month growth of Total Sales, Total Profit and Total Orders for most months.
3. The Toys category is the best performing category interms of sales while Arts and Crafts category interms of profit and Orders made

### Limitations
I had to work with some blank recors for stock_in_hand column since some products sold earlier did not have records in the inventory file.

### References
1. [Stack Overflow](https://www.stackoverflow.com)
2. [Power BI Documentation](https://www.microsoft.com)
