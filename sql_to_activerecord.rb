# 1. SELECT * FROM users;
users = User.all

# 2. SELECT *
# FROM users
# WHERE user.id = 1;
users = User.find(1)

# 3. SELECT *
# FROM posts
# ORDER BY created_at DESC
# LIMIT 1;
posts = Post.order(created_at: :desc)

# 4. SELECT *
# FROM users
# JOIN posts
# ON posts.author_id = users.id
# WHERE posts.created_at >= '2014-08-31 00:00:00';
User.joins(:posts).where("posts.created_at >= '2014-08-31 00:00:00'")

# 5. SELECT count(*)
# FROM users
# GROUP BY name
# HAVING count(*) > 1;

User.all.group(:name).count

User.select('COUNT(*) AS num_users').group(:name).having('num_users >= 3')

User.select('COUNT(*) AS num_users').group('name').having('num_users > 1')


# 6. The most recently updated user
User.order(updated_at: :desc).limit(1)

# 7. The oldest user (by age)
User.order(age: :desc).limit(1)

# 8. all the users
User.all

# 9. all posts sorted in descending order by date created
Post.order(created_at: :desc)
