-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

-- önce her subject için tarih bazında scoreları bulalım bi:
WITH subject_score AS (
  SELECT
    subject,
    score,
    quiz_date
  FROM daily_quiz_scores
),
-- sonra bu scoreları yine subject bazından sıralayalım bakalım tarih bazında artan sırada:
subject_row_nums AS (
SELECT
    subject,
    score,
    quiz_date,
    ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date ASC) AS row_num_asc,
    ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date DESC) AS row_num_desc   
FROM subject_score
)
-- sonra da bu ikinci cte'den artık row_num'ı en küçük ve büyük olanları getirelim her subject için:
SELECT 
  subject,
  MAX(CASE WHEN row_num_asc = 1 THEN score END) AS first_score_recorded,
  MAX(CASE WHEN row_num_desc = 1 THEN score END) AS last_score_recorded
FROM subject_row_nums
GROUP BY subject
