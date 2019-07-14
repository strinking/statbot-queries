-- Lists all channels by number of messages.

SELECT channels.name, t.*
FROM (
    SELECT channel_id, count(*)
    FROM messages
    WHERE guild_id = 181866934353133570 -- Programming
    GROUP BY channel_id
) AS t
JOIN channels
    ON channels.channel_id = t.channel_id
ORDER BY channels.name;
