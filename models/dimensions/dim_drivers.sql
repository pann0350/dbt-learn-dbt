{{
    config(
        materialized='incremental',
        unique_key='driver_id',
        incremental_strategy='delete+insert',
        on_schema_change='sync_all_columns'
    )
}}

SELECT DISTINCT ON (driver_id)
    driver_id,
    driver_slug,
    driver_first_name,
    driver_last_name,
    driver_short_name,
    driver_nationality
from {{ ref('stg_drivers') }}
where driver_id is not null
