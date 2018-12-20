-- Ensures all users are either members, guests, or staff.

SELECT
    users.real_user_id,
    users.name
FROM users
JOIN guild_membership
    ON guild_membership.int_user_id = users.int_user_id
WHERE guild_membership.guild_id = 181866934353133570 -- Programming
    AND guild_membership.is_member
    AND users.real_user_id NOT IN (
        -- Ignore special-case bots that don't have the 'Bot' role
        302050872383242240, -- DISBOARD
        404369151352766474, -- Discord Center
        478546253169295363, -- DiscordLink
        476259371912003597, -- Discord.me
        422087909634736160, -- Discord Server List
        436114445098287104, -- Discord Servers
        493224032167002123, -- Discordservers.me
        212681528730189824, -- DLM
        329566197043560460, -- InfoBot
        315926021457051650, -- Server Monitoring
        0                   -- Removed in GDPR request
    )
    AND users.int_user_id NOT IN (
        SELECT int_user_id
        FROM role_membership
        WHERE role_id IN (
            181869470736842752, -- Bot
            205477488707502081, -- Member
            473981157122244619, -- Moderator
            290546513656938496, -- Admin
            392613716807647233  -- Staff Emeritus
        )
    )
GROUP BY users.real_user_id, users.int_user_id
ORDER BY users.name, users.real_user_id;
