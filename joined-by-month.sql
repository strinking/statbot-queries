SELECT
    DATE_TRUNC('month', joined_at) AS month,
    COUNT(int_user_id) AS joined
FROM guild_membership
WHERE guild_id = 181866934353133570 -- Programming
GROUP BY month
ORDER BY month;
