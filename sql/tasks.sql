drop table tasks
;
CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    email VARCHAR(512) NOT NULL,
    start_date DATE,
    due_date DATE,
    priority TINYINT NOT NULL DEFAULT 3,
    description TEXT,
    update_at TIMESTAMP,
    PRIMARY KEY (task_id)
);

INSERT INTO tasks(title, priority, start_date, due_date, email, description, update_at)
VALUES
	('1th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'dave@fake.com', 'get some food', CURRENT_TIMESTAMP()),
	('2th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'emma@fake.com', 'make dinner', CURRENT_TIMESTAMP()), 
	('3th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'whoop@fake.com', 'clean the house', CURRENT_TIMESTAMP());