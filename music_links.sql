-- This query extracts YouTube URLs from #music.
-- It works on messages with multiple links, and
-- doesn't need any regex or parsing since it
-- just queries the list of embeds.

SELECT DISTINCT json_array_elements(embeds::json)->>'url' AS url
FROM messages
WHERE channel_id = 280778849615216640 -- #music
AND (
    content LIKE '%youtube.com/watch%'
    OR content LIKE '%youtube.com/playlist%'
    OR content LIKE '%youtu.be/%'
);
