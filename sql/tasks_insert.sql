INSERT INTO tasks(title,priority)
VALUES('Learn MySQL INSERT Statement',1);

INSERT INTO tasks(title,start_date,due_date)
VALUES('Use current date for the task',CURRENT_DATE(),CURRENT_DATE());

INSERT INTO tasks(title, priority, start_date, due_date)
VALUES
	('My first task', 1, CURRENT_DATE(), CURRENT_DATE()),
	('It is the second task',2, CURRENT_DATE(), CURRENT_DATE()),
	('This is the third task of the week',3, CURRENT_DATE(), CURRENT_DATE());