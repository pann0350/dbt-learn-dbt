{{ config(materialized='view') }}

SELECT 
	lower(split_part(driver_url, '/', 8)) AS driver_id, 
	lower(split_part(driver_url, '/', 9)) AS driver_slug, 
	driver_first_name,
	driver_last_name,
	driver_short_name,
	driver_nationality,
	lower(split_part(team_url, '/', 8)) AS team_id,
	team
FROM {{ source('f1', 'raw_drivers') }}
