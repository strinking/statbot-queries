-- Helper function to convert Discord IDs into snowflakes purely within Postgres
-- Equivalent in Python:
--  datetime.utcfromtimestamp(((id >> 22) + DISCORD_EPOCH) / 1000)
-- where DISCORD_EPOCH is 1420070400000

CREATE FUNCTION snowflake_time(id BIGINT)
    RETURNS TIMESTAMP WITH TIME ZONE
    LANGUAGE SQL
    AS 'SELECT to_timestamp(((id >> 22) + 1420070400000) / 1000) AS timestamp'
    RETURNS NULL ON NULL INPUT
    IMMUTABLE;
