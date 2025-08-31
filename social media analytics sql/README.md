# Social Media Analytics SQL Database

This project implements a SQL database for analyzing user activity and engagement on a social media platform. The database efficiently stores and retrieves data about users, posts, likes, comments, and following relationships.

## Database Schema

The database consists of the following tables:

- **users**: Stores user information (user_id, username, email, created_at)
- **posts**: Stores post data (post_id, user_id, content, created_at)
- **likes**: Stores like interactions (like_id, user_id, post_id, created_at)
- **comments**: Stores comments (comment_id, user_id, post_id, content, created_at)
- **following**: Stores following relationships (following_id, follower_id, followee_id, created_at)

Indexes are added on foreign keys and timestamps for efficient queries.

## Files

- `schema.sql`: Database schema creation script
- `sample_data.sql`: Sample data for testing
- `analytics_queries.sql`: Sample analytics queries
- `TODO.md`: Project task list

## Setup Instructions

### Option 1: Manual SQL Setup
1. Install a SQL database system (e.g., MySQL, PostgreSQL, or SQLite).
2. Run the schema script to create the database:
   - For MySQL/PostgreSQL: `mysql -u username -p database_name < schema.sql`
   - For SQLite: `sqlite3 social_media.db < schema.sql`
3. Insert sample data:
   - `sqlite3 social_media.db < sample_data.sql`
4. Run analytics queries:
   - `sqlite3 social_media.db < analytics_queries.sql`

### Option 2: Python Script (Recommended)
1. Ensure Python 3 is installed.
2. Run the main script:
   - `python main.py`
   This will create the database, insert sample data, and run sample analytics queries.

### Option 3: Web Application (Full Platform)
1. Install Python 3 and pip.
2. Install dependencies:
   - `pip install -r requirements.txt`
3. Run the Flask web application:
   - `python app.py`
4. Open your browser and navigate to `http://127.0.0.1:5000/`
   This will launch the full web platform with dashboard, user management, posts, and analytics.

## Analytics Queries

The `analytics_queries.sql` file contains 10 sample queries for:

1. Total posts per user
2. Most liked posts
3. Posts with most comments
4. User engagement per post
5. Followers count per user
6. Following count per user
7. Recent posts
8. Top users by engagement
9. Average engagement per post
10. Posts with no engagement

## Usage

Use the analytics queries to gain insights into user behavior, post popularity, and platform engagement. Modify the queries as needed for specific analysis requirements.

## Notes

- The schema uses standard SQL syntax compatible with most RDBMS.
- Foreign key constraints ensure data integrity.
- Unique constraints prevent duplicate likes and follows.
- Timestamps allow for time-based analytics.

## Software and Hardware Used

### Software
- Python 3.x
- Flask 2.3.3 (Python web framework)
- SQLite (lightweight SQL database)
- SQL (Structured Query Language for database schema and queries)
- HTML5, CSS3 (for web frontend)
- pip (Python package installer)

### Hardware
- Development machine running Windows 11
- Typical modern PC or laptop capable of running Python and a web browser
- Web browser (e.g., Chrome, Firefox, Edge) for accessing the web interface
