from flask import Flask, render_template, request
import sqlite3
import os

app = Flask(__name__)

def get_db_connection():
    conn = sqlite3.connect('social_media.db')
    conn.row_factory = sqlite3.Row
    return conn

@app.route('/')
def index():
    conn = get_db_connection()
    
    # Get recent posts with user info
    posts = conn.execute('''
        SELECT p.*, u.username 
        FROM posts p 
        JOIN users u ON p.user_id = u.user_id 
        ORDER BY p.created_at DESC 
        LIMIT 10
    ''').fetchall()
    
    # Get user stats
    user_stats = conn.execute('''
        SELECT 
            COUNT(DISTINCT u.user_id) as total_users,
            COUNT(DISTINCT p.post_id) as total_posts,
            COUNT(DISTINCT l.like_id) as total_likes,
            COUNT(DISTINCT c.comment_id) as total_comments
        FROM users u
        LEFT JOIN posts p ON u.user_id = p.user_id
        LEFT JOIN likes l ON p.post_id = l.post_id
        LEFT JOIN comments c ON p.post_id = c.post_id
    ''').fetchone()
    
    conn.close()
    return render_template('index.html', posts=posts, stats=user_stats)

@app.route('/users')
def users():
    conn = get_db_connection()
    users = conn.execute('SELECT * FROM users ORDER BY created_at DESC').fetchall()
    conn.close()
    return render_template('users.html', users=users)

@app.route('/posts')
def posts():
    conn = get_db_connection()
    posts = conn.execute('''
        SELECT p.*, u.username,
               COUNT(DISTINCT l.like_id) as like_count,
               COUNT(DISTINCT c.comment_id) as comment_count
        FROM posts p
        JOIN users u ON p.user_id = u.user_id
        LEFT JOIN likes l ON p.post_id = l.post_id
        LEFT JOIN comments c ON p.post_id = c.post_id
        GROUP BY p.post_id
        ORDER BY p.created_at DESC
    ''').fetchall()
    conn.close()
    return render_template('posts.html', posts=posts)

@app.route('/analytics')
def analytics():
    conn = get_db_connection()
    
    # Top users by posts
    top_posters = conn.execute('''
        SELECT u.username, COUNT(p.post_id) as post_count
        FROM users u
        LEFT JOIN posts p ON u.user_id = p.user_id
        GROUP BY u.user_id, u.username
        ORDER BY post_count DESC
        LIMIT 5
    ''').fetchall()
    
    # Most liked posts
    top_liked = conn.execute('''
        SELECT p.content, u.username, COUNT(l.like_id) as like_count
        FROM posts p
        JOIN users u ON p.user_id = u.user_id
        LEFT JOIN likes l ON p.post_id = l.post_id
        GROUP BY p.post_id
        ORDER BY like_count DESC
        LIMIT 5
    ''').fetchall()
    
    conn.close()
    return render_template('analytics.html', top_posters=top_posters, top_liked=top_liked)

if __name__ == '__main__':
    if not os.path.exists('social_media.db'):
        # Run the main.py to create DB if not exists
        os.system('python main.py')
    app.run(debug=True)
