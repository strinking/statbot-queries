-- This query enumerates users who have embeds,
-- but were not made by bot accounts.
-- This might mean that they are running selfbots.
-- However, do know that embeds are also generated normally
-- by Discord for attached files or links.

SELECT DISTINCT
    users.name,
    users.real_user_id,
    users.int_user_id,
    COUNT(messages.message_id)
FROM messages
JOIN users
    ON users.int_user_id = messages.int_user_id
WHERE messages.guild_id = 181866934353133570 -- Programming
    AND messages.embeds != '[]'
    AND NOT users.is_bot
GROUP BY users.name, users.real_user_id, users.int_user_id
ORDER BY count DESC;
