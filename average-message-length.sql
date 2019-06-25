-- Gets the average length of messages by user.
-- Does not include messages that are empty.

SELECT
    users.name,
    users.int_user_id,
    users.real_user_id,
    users.is_bot,
    COUNT(ss.int_user_id) AS total_messages,
    AVG(ss.length) as average_length
FROM (
    SELECT
        int_user_id,
        LENGTH(content) as length
    FROM messages
    WHERE content != ''
    GROUP BY int_user_id, LENGTH(content)
) AS ss
JOIN users
    ON users.int_user_id = ss.int_user_id
GROUP BY users.name, users.int_user_id, users.real_user_id
ORDER BY average_length DESC;
