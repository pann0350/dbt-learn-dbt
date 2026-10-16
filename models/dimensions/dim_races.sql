{{
    config(
        materialized='incremental',
        unique_key='race_id',
        incremental_strategy='delete+insert',
        on_schema_change='sync_all_columns'
    )
}}

SELECT DISTINCT ON (race_id)
    race_id,
    "year" as season_year,
    grand_prix,
    grand_prix_slug,
    race_date
from {{ ref('stg_races') }}
where race_id is not null

-- To include race_date, first alias the expression in stg_races.sql:
-- to_date(date || ' ' || year, 'DD Mon YYYY') AS race_date
-- Then add race_date to the select above.
