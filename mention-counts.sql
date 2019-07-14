--- Displays which users have been mentioned the most
--- Invalid mentions are ignored

SELECT
    mentions.user_id,
    users.name,
    mentions.count AS mentions
FROM (
    SELECT
        mentioned_id AS user_id,
        COUNT(mentioned_id)
    FROM mentions
    WHERE guild_id = 181866934353133570 -- Programming
    GROUP BY user_id
) AS mentions
JOIN users
    ON users.real_user_id = mentions.user_id
GROUP BY mentions.user_id, mentions.count, users.name
ORDER BY mentions DESC;
