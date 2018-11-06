-- A query to erase identifying user information about a member
-- to comply with a GDPR data removal request or similar.

UPDATE users
SET
    real_user_id = 0,
    name = 'Removed for legal reasons - $random_hex',
    discriminator = 0000,
    avatar = 00000000000000000000000000000000
WHERE
    real_user_id = $user_id;
