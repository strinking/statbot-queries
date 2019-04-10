-- Gets the top 100 (mentioning, mentioned) user pairs.

-- this outer query is only necessary for prettying up the output.
SELECT
    mentioning_users.name || '#' || mentioning_users.discriminator AS mentioning,
    mentioned_users.name || '#' || mentioned_users.discriminator AS mentioned,
    count
FROM (
    SELECT -- the real query begins here.
        mentioning_users.real_user_id AS mentioning_user_id,
        mentioned_users.real_user_id AS mentioned_user_id,
        COUNT(*) AS count
    FROM mentions
        JOIN users AS mentioned_users ON mentioned_id = mentioned_users.real_user_id
        -- because `mentions` doesn't include the mentioning user id, we need to get the message...
        JOIN messages AS m1 ON mentions.message_id = m1.message_id
        -- and from the message, get the mentioning user
        JOIN users AS mentioning_users ON m1.int_user_id = mentioning_users.int_user_id
    WHERE
        type='USER' AND
        -- Programming
        mentions.guild_id = 181866934353133570
    GROUP BY mentioning_user_id, mentioned_user_id
    ORDER BY count DESC
    LIMIT 100 -- change this for more (or less) pairs
) AS collected_mentions
    JOIN users AS mentioning_users ON mentioning_users.real_user_id = mentioning_user_id
    JOIN users AS mentioned_users ON mentioned_users.real_user_id = mentioned_user_id
ORDER BY count DESC;
