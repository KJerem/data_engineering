-- Config for materialization as an external table in Parquet format
{{ config(
    materialized = 'external',
    location = 'output/trips_2024_transformed.parquet',
    file_format = 'parquet'
) }} 
-- Test data source from yml
-- SELECT  tpep_pickup_datetime, tpep_dropoff_datetime, trip_distance, passenger_count, total_amount
-- FROM {{  source('tlc_taxi_trips', 'raw_yellow_tripdata') }}
-- LIMIT 10
-- Define CTEs to filter out invalid trips
-- Define data source
WITH source_data AS (
    SELECT
        * EXCLUDE (VendorID, RateCodeID)
    FROM
        {{ source('tlc_taxi_trips', 'raw_yellow_tripdata') }}
),
-- Apply filters to clean the data
filtered_data AS (
    SELECT
        *
    FROM
        source_data
    WHERE
        passenger_count > 0 -- Exclude trips with zero passengers
        AND trip_distance > 0 -- Exclude trips with zero or negative distance
        AND total_amount > 0 -- Exclude trips with zero or negative total amount
        AND tpep_pickup_datetime < tpep_dropoff_datetime -- Exclude trips with negative duration
        AND store_and_fwd_flag = 'N' -- Exclude trips that were stored and forwarded
        AND tip_amount >= 0 -- Exclude trips with negative tip amount
        AND payment_type IN (1, 2) -- Exclude trips with invalid payment types
),
-- Final transformed data
transformed_data AS (
    SELECT
        -- Type casting: Convert passenger_count to integer
        CAST(passenger_count AS INTEGER) AS passenger_count,
        -- Normalization: Map payment_type to human-readable format
        CASE
            WHEN payment_type = 1 THEN 'Credit Card'
            WHEN payment_type = 2 THEN 'Cash'
        END AS payment_method,
        -- Feature engineering: Calculate trip duration in minutes
        DATE_DIFF(
            'minute',
            tpep_pickup_datetime,
            tpep_dropoff_datetime
        ) AS trip_duration_minutes,
        -- Select other relevant columns
        * EXCLUDE (passenger_count, payment_type)
    FROM
        filtered_data
),
-- Filter for trips in the year 2024
final_data AS (
    SELECT
        *,
        CAST(tpep_pickup_datetime AS DATE) AS pickup_date,
        CAST(tpep_dropoff_datetime AS DATE) AS dropoff_date
    FROM
        transformed_data
    WhERE
        pickup_date >= '2024-01-01'
        AND pickup_date < '2025-01-01' -- Filter for trips in the year 2024
        AND dropoff_date >= '2024-01-01'
        AND dropoff_date < '2025-01-01' -- Filter for trips in the year 2024
) -- Select final transformed data
SELECT
    * EXCLUDE (pickup_date, dropoff_date)
FROM
    final_data
WHERE
    trip_duration_minutes > 0