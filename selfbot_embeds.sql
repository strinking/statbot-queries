-- This query counts how many messages have embeds,
-- but were not made by bot accounts.
-- This means that they are running selfbots.

SELECT count(*)
FROM messages
JOIN users
    ON messages.user_id = users.user_id
WHERE messages.guild_id = 181866934353133570 -- Programming
AND messages.embeds != '[]'
AND NOT users.is_bot;
