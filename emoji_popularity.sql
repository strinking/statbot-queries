--- Based on the query from "emoji_usage.sql" to get which
--- emoji are the most popular.

SELECT
    ss.emoji[2] AS name,
    ss.emoji[3] AS id,
    ss.emoji[1] = 'a' AS animated,
    count(ss.emoji[3])
FROM (
    SELECT (
        SELECT regexp_matches(content, '<(a?):([A-Za-z0-9_-]+):([0-9]+)>')
    ) AS emoji
    FROM messages
    WHERE guild_id = 181866934353133570 -- Programming
) AS ss
WHERE ss.emoji IS NOT NULL
GROUP BY ss.emoji
ORDER BY count DESC;
