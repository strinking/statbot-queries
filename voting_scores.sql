-- Lower bound of Wilson score confidence interval
-- See: http://www.evanmiller.org/how-not-to-sort-by-average-rating.html

SELECT ss.message_id,
       ((ss.upvotes + 1.9208) / (ss.upvotes + ss.downvotes) - 1.96 * SQRT(
         (ss.upvotes * ss.downvotes) /
         (ss.upvotes + ss.downvotes) + 0.9604) / (
           ss.upvotes + ss.downvotes)
       ) / (1 + 3.8416 / (ss.upvotes + ss.downvotes)) AS score
FROM (
    SELECT
        reactions.message_id,
        COUNT(DISTINCT upvotes.int_user_id) AS upvotes,
        COUNT(DISTINCT downvotes.int_user_id) AS downvotes
    FROM reactions
    LEFT JOIN (
        SELECT
            message_id,
            int_user_id
        FROM reactions
        WHERE emoji_id IN (
            318786506691051521, -- updoot
            430119347881771018, -- upvote
            356850207503286272 -- Upvote
        )
        OR emoji_unicode IN (
            '👍',
            '👆',
            '🔼',
            '⏫',
            '⬆'
        )
        GROUP BY message_id, int_user_id
    ) AS upvotes
        ON reactions.message_id = upvotes.message_id
    LEFT JOIN (
        SELECT
            message_id,
            int_user_id
        FROM reactions
        WHERE emoji_id IN (
            -- FIXME: these somehow ended up being the same
            318786506271621130, -- downdoot
            318786506271621130, -- downvote
            318786506271621130 -- Downvote
        )
        OR emoji_unicode IN (
            '👎',
            '🔽',
            '⏬',
            '⬇'
        )
        GROUP BY message_id, int_user_id
    ) AS downvotes
        ON reactions.message_id = downvotes.message_id
    WHERE message_id > 0 -- Restrict which messages are considered
    GROUP BY reactions.message_id
    ORDER BY upvotes DESC, downvotes ASC, message_id DESC
) AS ss
WHERE ss.upvotes + ss.downvotes > 0
ORDER BY score DESC;
