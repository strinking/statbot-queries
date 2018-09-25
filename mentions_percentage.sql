--- Lists users by what percentage of their messages have a mention in them.
--- Only counts users with more than 400 messages.

SELECT
    users.name,
    users.int_user_id,
    users.real_user_id,
    users.is_bot,
    100.0 * COUNT(messages.int_user_id) / total_messages.count AS percentage
FROM (
    SELECT
        messages.message_id,
        messages.int_user_id
    FROM mentions
    JOIN messages
        ON messages.message_id = mentions.message_id
    WHERE messages.guild_id = 181866934353133570 -- Programming
    GROUP BY messages.message_id
) AS messages
JOIN users
    ON users.int_user_id = messages.int_user_id
JOIN (
    SELECT
        int_user_id,
        COUNT(int_user_id)
    FROM messages
    GROUP BY int_user_id
) AS total_messages
    ON total_messages.int_user_id = messages.int_user_id
WHERE total_messages.count > 400 -- Limit people
GROUP BY users.int_user_id, users.real_user_id, total_messages.count
ORDER BY percentage DESC;
