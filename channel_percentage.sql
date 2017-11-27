-- This query measures the "meme" ratio of our guild.
-- Really this is just what percentage of a person's
-- posts are in #general vs. the rest of the guild.
-- Since percentages for people with low post counts
-- can be skewed, this query will ignore those with
-- fewer than 400 messages total.

SELECT
    users.name,
    totals.user_id,
    100.0 * general.count / totals.count as percentage,
    totals.count as total_messages
FROM (
    SELECT
        user_id,
        COUNT(user_id)
    FROM messages
    WHERE guild_id = 181866934353133570 -- Programming
    GROUP BY user_id
) as totals
JOIN (
    SELECT
        user_id,
        COUNT(user_id)
    FROM messages
    WHERE channel_id = 181866934353133570 -- #general
    GROUP BY user_id
) as general
    ON totals.user_id = general.user_id
JOIN users
    ON totals.user_id = users.user_id
WHERE totals.count > 400 -- Limit to people 400 posts or more
GROUP BY totals.user_id, general.count, totals.count, users.name
ORDER BY percentage DESC;
