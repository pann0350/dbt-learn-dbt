{{
    config(
        materialized='incremental',
        unique_key='team_id',
        incremental_strategy='delete+insert',
        on_schema_change='sync_all_columns'
    )
}}

-- stg_teams reads from raw_drivers, so a team may appear on many rows.
-- Group to one row per team_id before the incremental insert.
SELECT DISTINCT ON (team_id)
    team_id,
    team AS team_name
FROM {{ ref('stg_drivers') }}
WHERE team_id IS NOT NULL
ORDER BY team_id, team ASC NULLS LAST
