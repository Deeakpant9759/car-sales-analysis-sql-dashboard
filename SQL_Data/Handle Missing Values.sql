-- Create a table of rows with missing values for key fields
SELECT vin, make, model, transmission, trim, mmr, sellingprice,
       saledate, state, odometer,
       CASE WHEN make IS NULL THEN 1 ELSE 0 END AS missing_make,
       CASE WHEN model IS NULL THEN 1 ELSE 0 END AS missing_model,
       CASE WHEN transmission IS NULL THEN 1 ELSE 0 END AS missing_transmission,
       CASE WHEN trim IS NULL THEN 1 ELSE 0 END AS missing_trim,
       CASE WHEN mmr IS NULL THEN 1 ELSE 0 END AS missing_mmr,
       CASE WHEN sellingprice IS NULL THEN 1 ELSE 0 END AS missing_selling_price,
       CASE WHEN saledate IS NULL THEN 1 ELSE 0 END AS missing_sale_date,
       CASE WHEN vin IS NULL THEN 1 ELSE 0 END AS missing_vin,
       CASE WHEN state IS NULL THEN 1 ELSE 0 END AS missing_state,
       CASE WHEN odometer IS NULL THEN 1 ELSE 0 END AS missing_odometer
INTO carsales.dbo.missing_values
FROM carsales.dbo.car_prices
WHERE make IS NULL OR model IS NULL OR transmission IS NULL OR trim IS NULL OR
      mmr IS NULL OR sellingprice IS NULL OR saledate IS NULL OR
      vin IS NULL OR state IS NULL OR odometer IS NULL;

-- Fill missing MMR and Selling Price using model-year average
WITH AvgPricesCTE AS (
    SELECT make, model, year,
           AVG(mmr) AS avg_mmr,
           AVG(sellingprice) AS avg_selling_price
    FROM carsales.dbo.car_prices
    GROUP BY make, model, year
)
UPDATE cp
SET mmr = ISNULL(cp.mmr, ap.avg_mmr),
    sellingprice = ISNULL(cp.sellingprice, ap.avg_selling_price)
FROM carsales.dbo.car_prices cp
JOIN AvgPricesCTE ap
  ON cp.make = ap.make AND cp.model = ap.model AND cp.year = ap.year
WHERE cp.saledate IS NULL AND (cp.mmr IS NULL OR cp.sellingprice IS NULL);

-- Remove remaining rows with missing data from main table
DELETE cp
FROM carsales.dbo.car_prices cp
INNER JOIN carsales.dbo.missing_values mv
  ON cp.vin = mv.vin AND cp.saledate = mv.saledate;
