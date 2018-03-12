--- Searches for custom emoji usage and outputs
--- all instances of their usage across all messages.

SELECT
    ss.channel_id,
    ss.user_id,
    ss.message_id,
    ss.emoji[3] AS emoji_id,
    ss.emoji[2] AS emoji_name,
    ss.emoji[1] = 'a' AS emoji_animated
FROM (
    SELECT channel_id, user_id, message_id, (
        SELECT regexp_matches(content, '<(a?):([A-Za-z0-9_-]+):([0-9]+)>')
    ) AS emoji
    FROM messages
    WHERE guild_id = 181866934353133570 -- Programming
) AS ss
WHERE ss.emoji IS NOT NULL;
