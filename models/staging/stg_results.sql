{{ config(materialized='view') }}

SELECT 
	lower(split_part(url, '/', 8))::int AS race_id,
	lower(split_part(url, '/', 9)) AS grand_prix_slug,
	CASE WHEN pos ~ '^[0-9]+$' THEN pos::INTEGER END AS pos,
	CASE WHEN no ~ '^[0-9]+$' THEN no::INTEGER END AS no,
	driver_first_name,
	driver_last_name,
	driver_short_name,
	team AS team_name,
	CASE WHEN laps ~ '^[0-9]+$' THEN laps::INTEGER END AS laps,	
	NULLIF(pts, '')::NUMERIC AS pts
FROM {{ source('f1', 'raw_results') }}
