-- Calculates the percentage of a user's messages are edited or deleted.
-- Add a WHERE int_user_id = $$ clause to limit to a single user.

SELECT
    COUNT(*) AS messages,
    COUNT(edited_at) AS edited,
    COUNT(deleted_at) AS deleted,
    100.0 * COUNT(edited_at) / COUNT(*) AS edited_percentage,
    100.0 * COUNT(deleted_at) / COUNT(*) AS deleted_percentage
FROM messages
WHERE guild_id = 181866934353133570; -- Programming
