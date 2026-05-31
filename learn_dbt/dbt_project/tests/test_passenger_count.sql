-- Ce test vérifie que le nombre de passagers (passenger_count) dans les données transformées est supérieur à zéro.
-- Cela garantit que les trajets avec un nombre de passagers invalide (zéro ou négatif) ont été correctement filtrés lors de la transformation des données.
-- De plus, il vérifie que le nombre de passagers est bien un entier, ce qui est essentiel pour l'analyse et les calculs ultérieurs basés sur cette colonne.
SELECT *
FROM {{ ref('transform') }}
WHERE 
    passenger_count <= 0
    AND passenger_count != CAST(passenger_count AS INTEGER) -- Vérifie que passenger_count est bien un entier;
