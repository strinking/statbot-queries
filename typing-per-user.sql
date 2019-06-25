-- Lists all users by how many times they've begun typing.
-- This is NOT the same as the number of messages they sent.

SELECT
    users.real_user_id,
    users.name,
    COUNT(typing.int_user_id) AS typing_count,
FROM typing
JOIN users
    ON typing.int_user_id = users.int_user_id
WHERE guild_id = 181866934353133570 -- Programming
GROUP BY typing.int_user_id, users.real_user_id, users.name
ORDER BY typing_count DESC, users.real_user_id;
