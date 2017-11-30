--- Lists users by what percentage of their messages have a mention in them.
--- Only counts users with more than 400 messages.

SELECT
    users.user_id,
    users.name,
    users.is_bot,
    100.0 * COUNT(messages.user_id) / total_messages.count AS percentage
FROM (
    SELECT
        messages.message_id,
        messages.user_id
    FROM mentions
    JOIN messages
        ON messages.message_id = mentions.message_id
    WHERE messages.guild_id = 181866934353133570 -- Programming
    GROUP BY messages.message_id
) AS messages
JOIN users
    ON users.user_id = messages.user_id
JOIN (
    SELECT
        user_id,
        COUNT(user_id)
    FROM messages
    GROUP BY user_id
) AS total_messages
    ON total_messages.user_id = messages.user_id
WHERE total_messages.count > 400 -- Limit people
GROUP BY users.user_id, total_messages.count
ORDER BY percentage DESC;

