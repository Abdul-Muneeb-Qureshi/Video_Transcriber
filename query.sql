-- Create the database
CREATE DATABASE youtube_tasks_db;

-- Use the database
USE youtube_tasks_db;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE task_status (
    id VARCHAR(100) PRIMARY KEY,
    user_id INT,
    video_title VARCHAR(255),
    status VARCHAR(50),
    download_link TEXT,
	transcript_link TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

ALTER TABLE task_status
RENAME COLUMN download_link TO audio_download_link;

ALTER TABLE task_status
ADD COLUMN audio_duration VARCHAR(50);



