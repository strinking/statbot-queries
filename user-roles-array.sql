-- A query to collect role IDs in rows into an array for easier group-querying.

SELECT
  guild_id,
  int_user_id,
  array_agg(role_id) AS role_ids
FROM role_membership
GROUP BY int_user_id, guild_id;
