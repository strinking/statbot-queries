--- Lists all users by how many times they have mentioned others.
--- For context, it also lists how many messages total.

SELECT
    mention_counts.*,
    message_counts.count AS total_messages
FROM (
    SELECT
        users.real_user_id,
        users.int_user_id,
        users.name,
        mentions.count AS total_mentions
    FROM (
        SELECT
            message_id,
            mentioned_id
        FROM mentions
        WHERE guild_id = 181866934353133570 -- Programming
    ) AS mentions
    JOIN messages
        ON messages.message_id = mentions.message_id
    JOIN users
        ON users.int_user_id = messages.int_user_id
    GROUP BY users.real_user_id, users.int_user_id
) AS mention_counts
JOIN (
    SELECT
        user_id,
        COUNT(user_id)
    FROM messages
    GROUP BY messages.user_id
) AS message_counts
    mention_counts.int_user_id = message_counts.int_user_id
ORDER BY total_mentions DESC, total_messages DESC;
