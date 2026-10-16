{{ config(materialized='view') }}

SELECT 
	lower(split_part(url, '/', 8))::int AS race_id, 
	to_date(date || ' ' || year, 'DD Mon YYYY') as race_date,
	"year",
	grand_prix,
	lower(split_part(url, '/', 9)) AS grand_prix_slug,
	winner_driver_first_name,
	winner_driver_last_name,
	winner_driver_short_name,
	winner_team AS winner_team_name,
	CASE WHEN winner_laps ~ '^[0-9]+$' THEN winner_laps::INTEGER END AS laps,
	winner_time
FROM {{ source('f1', 'raw_races') }}
