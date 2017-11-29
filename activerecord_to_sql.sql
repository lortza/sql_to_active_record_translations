-- 1. Post.all
SELECT *
  FROM posts;


-- 2. Post.first
SELECT *
  FROM posts p
  ORDER BY p.id ASC
  LIMIT 1;


-- 3. Post.last
SELECT *
  FROM posts p
  ORDER BY p.id DESC
  LIMIT 1;


-- 4. Post.where(:id => 4)
SELECT *
  FROM posts p
  WHERE p.id = 4;


-- 5. Post.find(4)
SELECT *
  FROM posts p
  WHERE p.id = 4
  LIMIT 1;


-- 6. User.count
SELECT COUNT(*)
  FROM users;


-- 7. Post.select(:title).where(:created_at > 3.days.ago).order(:created_at)
SELECT p.title
  FROM posts p
  WHERE p.created_at > CURRENT_DATE - 3
  ORDER BY p.created_at;


-- 8. Post.select("COUNT(*)").group(:category_id)
SELECT COUNT(*)
  FROM posts
  GROUP BY category_id;


-- 9. All posts created before 2014
SELECT *
  FROM posts
  WHERE created_at < '2014-01-01';


-- 10. A list of all (unique) first names for authors who have written at least 3 posts

-- 11. The posts with titles that start with the word "The"

-- 12. Posts with IDs of 3,5,7, and 9
