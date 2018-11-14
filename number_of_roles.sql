-- Lists all members by number of roles.
-- Helps ensure there are no role-less members on Programming.

SELECT
    users.real_user_id,
    COUNT(users.real_user_id) - 1 AS roles
FROM users
JOIN role_membership
    ON role_membership.int_user_id = users.int_user_id
JOIN guild_membership
    ON guild_membership.int_user_id = users.int_user_id
    AND guild_membership.guild_id = role_membership.guild_id
WHERE role_membership.guild_id = 181866934353133570 -- Programming
    AND guild_membership.is_member
    AND users.real_user_id != 0
GROUP BY users.real_user_id, users.int_user_id
ORDER BY roles, users.real_user_id;
