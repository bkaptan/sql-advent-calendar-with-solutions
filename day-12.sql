-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with message_count_per_day AS (
  SELECT  -- userların tarih bazından yolladıkları total mesajlar bulunur ve ranklenir
    DATE(m.sent_at) AS date,
    u.user_name,
    COUNT(m.message_id) AS message_count
  FROM npn_users u
  JOIN npn_messages m
  ON u.user_id = m.sender_id
  GROUP BY DATE(m.sent_at), u.user_name
),
ranked_message_count AS (
  SELECT
      date,
      user_name,
      message_count,
      RANK() OVER(PARTITION BY date ORDER BY message_count DESC) AS rnk -- bu rankler arasında her tarih için en yüksek olan user alınır
  FROM message_count_per_day
)
SELECT *
FROM ranked_message_count
WHERE rnk = 1
