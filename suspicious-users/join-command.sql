-- Looks for people who send '!join' right after joining,
-- and then deleted it soon after.

-- Uses snowflake_time from id_to_snowflake.sql

SELECT
    users.name || '#' || users.discriminator AS username,
    snowflake_time(users.real_user_id) AS created_at,
    messages.created_at AS message_sent,
    messages.deleted_at AS message_deleted,
    users.real_user_id,
    users.int_user_id
FROM messages
JOIN users
    ON messages.int_user_id = users.int_user_id
WHERE messages.content = '!join'
    AND messages.channel_id = 209074609893408768 -- #join
    AND messages.deleted_at IS NOT NULL
    AND messages.deleted_at - messages.created_at < '4 minutes'::interval;
