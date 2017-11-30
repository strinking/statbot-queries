--- Lists all users by how many times they have mentioned others.
--- For context, it also lists how many messages total, and
--- thus what percentage have mentions in them.

SELECT
    t0.*,
    t1.count AS total_messages,
    100.0 * t0.total_mentions / t1.count AS percentage
FROM (
    SELECT
        users.user_id,
        users.name,
        mentions.count AS total_mentions
    FROM (
        SELECT
            message_id,
            mentioned_id
        FROM mentions
    ) AS mentions
    JOIN messages
        ON messages.message_id = mentions.message_id
    JOIN users
        ON users.user_id = messages.user_id
    GROUP BY users.user_id, messages.user_id
) AS t0
JOIN (
    SELECT
        user_id,
        COUNT(user_id)
    FROM messages
    GROUP BY messages.user_id
) AS t1
    ON t0.user_id = t1.user_id
ORDER BY total_mentions DESC;

