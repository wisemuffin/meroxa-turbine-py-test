INSERT INTO tasks(title,priority)
VALUES('Learn MySQL INSERT Statement',1);

INSERT INTO tasks(title,start_date,due_date)
VALUES('Use current date for the task',CURRENT_DATE(),CURRENT_DATE());

INSERT INTO tasks(title, priority, start_date, due_date, customer_email)
VALUES
	('15th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'dave@fake.com'),
	('16th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'emma@fake.com'), 
	('17th task', 1, CURRENT_DATE(), CURRENT_DATE(), 'whoop@fake.com');