-- Store duplicate records (same VIN and SALEDATE) with averaged price data
WITH cte AS (
    SELECT vin, saledate, mmr, sellingprice,
           COUNT(*) OVER(PARTITION BY vin, saledate) AS counted
    FROM carsales.dbo.car_prices
),
subcte AS (
    SELECT vin, saledate,
           AVG(mmr) AS mmr,
           AVG(sellingprice) AS sellingprice
    FROM cte
    WHERE counted = 2
    GROUP BY vin, saledate
)
SELECT * 
INTO carsales.dbo.car_prices_duplicate
FROM subcte;

-- Delete duplicate records from main table
WITH cte AS (
    SELECT *,
           COUNT(*) OVER(PARTITION BY vin, saledate) AS counted
    FROM carsales.dbo.car_prices
)
DELETE FROM cte
WHERE counted = 2;
