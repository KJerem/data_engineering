-- Analyse exploratoire des données de taxi à New York
-- Source des données : 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet' 

-- 0. Aperçu des données
-- SELECT 
--     * 
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet' 
-- LIMIT 10;

-- SELECT 
--     COUNT(*) 
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet';


-- 1. Analyse de la distribution des variables catégorielles

-- SELECT VendorID , COUNT(*) AS nombre_trips
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
-- GROUP BY VendorID;

-- SELECT RateCodeID, COUNT(*) AS nombre_trips
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
-- GROUP BY RateCodeID;

-- SELECT store_and_fwd_flag, COUNT(*) AS nombre_trips
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
-- GROUP BY store_and_fwd_flag;

-- SELECT payment_type, COUNT(*) AS nombre_trips
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
-- GROUP BY payment_type;

-- SELECT payment_type, COUNT(*) AS nombre_trips
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
-- GROUP BY payment_type;

-- SELECT PULocationID, COUNT(*) AS nombre_trips
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
-- GROUP BY PULocationID;


-- SELECT DOLocationID, COUNT(*) AS nombre_trips
-- FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
-- GROUP BY DOLocationID;

-- Trajet negatif => tpep_pickup_datetime(heure de prise en charge) > tpep_dropoff_datetime(heure de dépose)
SELECT COUNT(*) AS nombre_trips
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE tpep_pickup_datetime > tpep_dropoff_datetime;

SELECT *
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE tpep_pickup_datetime > tpep_dropoff_datetime
LIMIT 10;

SELECT COUNT(*) AS nombre_trips
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE trip_distance <= 0;

SELECT tpep_pickup_datetime, tpep_dropoff_datetime, trip_distance, passenger_count
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE trip_distance < 0
LIMIT 10;

SELECT tpep_pickup_datetime, tpep_dropoff_datetime, trip_distance, passenger_count
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE trip_distance = 0
LIMIT 10;

SELECT COUNT(*) AS nombre_trips
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE total_amount <= 0;

SELECT tpep_pickup_datetime, tpep_dropoff_datetime, trip_distance, passenger_count, total_amount
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE total_amount < 0
LIMIT 10;

SELECT tpep_pickup_datetime, tpep_dropoff_datetime, trip_distance, passenger_count, total_amount
FROM 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet'
WHERE total_amount = 0
LIMIT 10;