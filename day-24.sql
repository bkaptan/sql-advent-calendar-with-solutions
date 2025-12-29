-- SQL Advent Calendar - Day 24
-- Title: New Year Goals - User Type Analysis
-- Difficulty: hard
--
-- Question:
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--

-- Table Schema:
-- Table: user_goals
--   user_id: INT
--   user_type: VARCHAR
--   goal_id: INT
--   goal_status: VARCHAR
--

-- My Solution:

-- her kulanıcının "Completed Goals" sayısını, user_type bazında bulalım:
WITH users_completed_goals AS (
  SELECT 
      user_id,
      user_type,
      COUNT(goal_status) AS complited_goals
  FROM user_goals
  WHERE goal_status = 'Completed'
  GROUP BY user_id, user_type
)
SELECT  -- sonra user_type'ları gruplayarak ortalama "Completed Goals" bulunur:
  user_type,
  AVG(complited_goals) AS average_complited_goals
FROM users_completed_goals
GROUP BY user_type
