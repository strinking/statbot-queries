-- This query enumerates users who have embeds,
-- but were not made by bot accounts.
-- This might mean that they are running selfbots.

SELECT DISTINCT users.user_id, users.name, count(messages.message_id)
FROM messages
JOIN users
    ON messages.user_id = users.user_id
WHERE messages.guild_id = 181866934353133570 -- Programming
AND messages.embeds != '[]'
AND NOT users.is_bot
GROUP BY users.user_id, users.name
ORDER BY count DESC;
