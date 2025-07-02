-- Convert SALEDATE to proper DATETIME format where needed
UPDATE carsales.dbo.car_prices
SET saledate = TRY_CAST(
    TRIM(SUBSTRING(
        saledate,
        CHARINDEX(' ', saledate),
        CHARINDEX('GMT', saledate) - CHARINDEX(' ', saledate)
    )) AS datetime)
WHERE LEN(saledate) = 39;

-- Move VINs with invalid length to a separate table
SELECT * 
INTO carsales.dbo.car_prices_messy
FROM carsales.dbo.car_prices
WHERE LEN(vin) <> 17;

-- Remove invalid VIN records from main table
DELETE FROM carsales.dbo.car_prices
WHERE LEN(vin) <> 17 OR vin IS NULL;

-- Standardize text fields to uppercase and trimmed
UPDATE carsales.dbo.car_prices
SET make = UPPER(TRIM(make)),
    model = UPPER(TRIM(model)),
    state = UPPER(TRIM(state)),
    color = UPPER(TRIM(color)),
    body = UPPER(TRIM(body)),
    transmission = UPPER(TRIM(transmission)),
    trim = UPPER(TRIM(trim)),
    interior = UPPER(TRIM(interior)),
    seller = UPPER(TRIM(seller));

-- Replace inconsistent make names with standardized values
UPDATE carsales.dbo.car_prices
SET make = CASE
    WHEN make = 'CHEV TRUCK' THEN 'CHEVROLET'
    WHEN make = 'DODGE TK' THEN 'DODGE'
    WHEN make IN ('FORD TK', 'FORD TRUCK') THEN 'FORD'
    WHEN make = 'GMC TRUCK' THEN 'GMC'
    WHEN make = 'HYUNDAI TK' THEN 'HYUNDAI'
    WHEN make = 'LANDROVER' THEN 'LAND ROVER'
    WHEN make = 'MAZDA TK' THEN 'MAZDA'
    WHEN make IN ('MERCEDES', 'MERCEDES-B') THEN 'MERCEDES-BENZ'
    WHEN make = 'VW' THEN 'VOLKSWAGEN'
    ELSE make
END
WHERE make IS NOT NULL;

-- Remove placeholder values (example: long dash as color)
UPDATE carsales.dbo.car_prices
SET color = NULLIF(color, '—');
