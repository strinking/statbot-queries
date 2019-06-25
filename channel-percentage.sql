-- This query measures the "meme" ratio of our guild.
-- Really this is just what percentage of a person's
-- posts are in #off-topic vs. the rest of the guild.
-- Since percentages for people with low post counts
-- can be skewed, this query will ignore those with
-- fewer than 400 messages total.

SELECT
    users.name,
    users.int_user_id,
    users.real_user_id,
    100.0 * offtopic.count / totals.count as percentage,
    offtopic.count as offtopic_messages,
    totals.count as total_messages
FROM (
    SELECT
        int_user_id,
        COUNT(int_user_id)
    FROM messages
    WHERE guild_id = 181866934353133570 -- Programming
    GROUP BY int_user_id
) as totals
JOIN (
    SELECT
        int_user_id,
        COUNT(int_user_id)
    FROM messages
    WHERE channel_id = 181866934353133570 -- #off-topic
    GROUP BY int_user_id
) as offtopic
    ON totals.int_user_id = offtopic.int_user_id
JOIN users
    ON totals.int_user_id = users.int_user_id
WHERE totals.count > 400 -- Limit to people 400 posts or more
GROUP BY users.name, users.int_user_id, users.real_user_id, offtopic.count, totals.count
ORDER BY percentage DESC;
