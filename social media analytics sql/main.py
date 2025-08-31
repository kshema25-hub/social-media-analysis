import sqlite3
import os

def create_database():
    """Create the database and tables."""
    conn = sqlite3.connect('social_media.db')
    cursor = conn.cursor()
    
    # Read and execute schema
    with open('schema.sql', 'r') as f:
        schema = f.read()
    cursor.executescript(schema)
    
    conn.commit()
    conn.close()
    print("Database and tables created successfully.")

def insert_sample_data():
    """Insert sample data."""
    conn = sqlite3.connect('social_media.db')
    cursor = conn.cursor()
    
    # Read and execute sample data
    with open('sample_data.sql', 'r') as f:
        data = f.read()
    cursor.executescript(data)
    
    conn.commit()
    conn.close()
    print("Sample data inserted successfully.")

def run_analytics_queries():
    """Run analytics queries and print results."""
    conn = sqlite3.connect('social_media.db')
    cursor = conn.cursor()
    
    queries = [
        ("Total posts per user:", """
            SELECT u.username, COUNT(p.post_id) AS total_posts
            FROM users u
            LEFT JOIN posts p ON u.user_id = p.user_id
            GROUP BY u.user_id, u.username
            ORDER BY total_posts DESC;
        """),
        ("Most liked posts:", """
            SELECT p.post_id, p.content, u.username AS author, COUNT(l.like_id) AS like_count
            FROM posts p
            JOIN users u ON p.user_id = u.user_id
            LEFT JOIN likes l ON p.post_id = l.post_id
            GROUP BY p.post_id, p.content, u.username
            ORDER BY like_count DESC
            LIMIT 5;
        """),
        ("User engagement:", """
            SELECT u.username,
                   SUM(eng.like_count + eng.comment_count) AS total_engagement
            FROM users u
            JOIN (
                SELECT p.user_id,
                       COUNT(DISTINCT l.like_id) AS like_count,
                       COUNT(DISTINCT c.comment_id) AS comment_count
                FROM posts p
                LEFT JOIN likes l ON p.post_id = l.post_id
                LEFT JOIN comments c ON p.post_id = c.post_id
                GROUP BY p.post_id, p.user_id
            ) eng ON u.user_id = eng.user_id
            GROUP BY u.user_id, u.username
            ORDER BY total_engagement DESC;
        """)
    ]
    
    for title, query in queries:
        print(f"\n{title}")
        cursor.execute(query)
        rows = cursor.fetchall()
        for row in rows:
            print(row)
    
    conn.close()

def main():
    if not os.path.exists('social_media.db'):
        create_database()
        insert_sample_data()
    else:
        print("Database already exists.")
    
    run_analytics_queries()

if __name__ == "__main__":
    main()
