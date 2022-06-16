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

/*
 * Initial Load
 */
INSERT INTO tasks(title, priority, start_date, due_date, email, description, update_at)
VALUES
	('1th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'dave@fake.com', 'get some food oops', CURRENT_TIMESTAMP()),
	('2th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'emma@fake.com', 'make dinner', CURRENT_TIMESTAMP()), 
	('3th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'whoop@fake.com', 'clean the house', CURRENT_TIMESTAMP())
;

/*
 * example insert
 */
INSERT INTO tasks(title, priority, start_date, due_date, email, description, update_at)
VALUES
	('4th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'ubuntu@fake.com', 'a new update', CURRENT_TIMESTAMP())
	;

/*
 * example delete
 */
;
delete from tasks where task_id = 1
;

/*
 * example update
 */

update tasks
set description='updated this to eat food', update_at=CURRENT_TIMESTAMP()
where task_id = 2
;

/*
 * check bin logs
 */

SHOW MASTER STATUS;
SHOW BINARY LOGS;
call mysql.rds_set_configuration('binlog retention hours', 24);
SHOW VARIABLES LIKE 'log_bin';
SHOW VARIABLES LIKE 'log_bin_basename';

/*
 * profile data
 */
select *
from tasks
;

