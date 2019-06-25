-- A query to see the messages nearby when striking said "rule 5",
-- to see what kinds of content is most common for that rule violation
--
-- Initial version

WITH origins AS (
    SELECT
        message_id,
        true AS callout
    FROM messages
    JOIN users
        ON messages.int_user_id = users.int_user_id
    WHERE real_user_id = 145718212552687616
    AND content ILIKE '%rule 5%'
),
prevified AS (
    SELECT
        callout,
        created_at,
        messages.message_id,
        lag(messages.message_id) OVER channel_window AS prev_msg_id
    FROM messages
    LEFT JOIN origins
        ON messages.message_id = origins.message_id
        WINDOW channel_window as (
            PARTITION by messages.channel_id
            ORDER BY messages.message_id
        )
)
SELECT
    m2.content AS prev_msg,
    m1.content AS msg
FROM prevified
JOIN messages AS m1
    ON prevified.message_id = m1.message_id
JOIN messages AS m2
    ON prevified.prev_msg_id = m2.message_id
WHERE callout = true
    AND m1.message_id < 582277879069409318
ORDER BY m1.created_at
DESC
LIMIT 200;
