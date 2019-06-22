-- Looks for suspicious new joins.
-- Specifically looks at people who made their account soon before joining,
-- and do not have the 'Member' role.

-- Uses snowflake_time from id_to_snowflake.sql

SELECT
    users.name || '#' || users.discriminator AS username,
    joined_at - snowflake_time(users.real_user_id) AS time_before_join,
    snowflake_time(users.real_user_id) AS created_at,
    guild_membership.joined_at,
    users.real_user_id,
    users.int_user_id
FROM guild_membership
JOIN users
    ON guild_membership.int_user_id = users.int_user_id
LEFT JOIN (
    SELECT *
    FROM role_membership
    WHERE role_membership.role_id = 205477488707502081 -- Member role
) AS members
    ON guild_membership.int_user_id = members.int_user_id
    AND guild_membership.guild_id = members.guild_id
WHERE joined_at - snowflake_time(users.real_user_id) < '30 days'::interval
    AND guild_membership.joined_at > '2019-06-22 07:22:29'::timestamp -- CHANGE ME
ORDER BY joined_at, created_at;
