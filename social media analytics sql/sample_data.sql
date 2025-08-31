-- Sample Data for Social Media Analytics Database

-- Insert users
INSERT INTO users (username, email) VALUES
('alice', 'alice@example.com'),
('bob', 'bob@example.com'),
('charlie', 'charlie@example.com'),
('diana', 'diana@example.com'),
('eve', 'eve@example.com');

-- Insert posts
INSERT INTO posts (user_id, content) VALUES
(1, 'Hello world! This is my first post.'),
(2, 'Enjoying the sunny weather today!'),
(1, 'Just finished a great book. Highly recommend it.'),
(3, 'Excited for the weekend!'),
(4, 'Sharing some thoughts on technology.'),
(2, 'Cooking up something delicious.'),
(5, 'Exploring new places is always fun.');

-- Insert likes
INSERT INTO likes (user_id, post_id) VALUES
(2, 1),
(3, 1),
(1, 2),
(4, 2),
(5, 3),
(2, 3),
(1, 4),
(2, 4),
(3, 5),
(4, 6),
(5, 7);

-- Insert comments
INSERT INTO comments (user_id, post_id, content) VALUES
(2, 1, 'Welcome to the platform!'),
(3, 1, 'Great first post!'),
(1, 2, 'I agree, the weather is lovely.'),
(4, 3, 'What book was it?'),
(1, 3, 'Thanks for the recommendation!'),
(5, 4, 'Looking forward to it!'),
(2, 5, 'Interesting insights.'),
(3, 6, 'Sounds yummy!'),
(4, 7, 'Where did you go?');

-- Insert following relationships
INSERT INTO following (follower_id, followee_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 4),
(3, 1),
(3, 5),
(4, 2),
(4, 3),
(5, 1),
(5, 4);
