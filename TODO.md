# Todo


## Add to terraform

MySQL backups https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html

currently setup in gui

# setup

spin up mysql
```bash
cd infra/infra_rds;
pipenv shell;
cdktf deploy;
```

make mysql publicly available.


setup meroxa access in snowflake
run sql/snowflake_setup.sql

spin up meroxa resources
```bash
cd infra/infra_meroxa
TODO - currently running it manually via uncommited meroxaapp/meroxa_create_resources.sh
```

deploy the meroxa turbine-py app
```bash
cd meroxaapp
pipenv shell
meroxa login
meroxa app deploy
```

insert data into mysql
run sql/tasks_insert.sql

check snowflake
```sql
select * from meroxa_db.stream_data.tasks
```


# debugging mysql to snowflake

## check mysql
```bash
 aws rds describe-db-instance-automated-backups --db-instance-identifier terraform-20220515222524333000000002
 ```

## mysql binlogs
```sql
SHOW MASTER STATUS;
SHOW BINARY LOGS;
```


## check binlog
 get the file from the mysql command above
 ```bash
mysqlbinlog --read-from-remote-server --host terraform-20220515222524333000000002.cmiwy84tb6yh.ap-southeast-2.rds.amazonaws.com --port 3306 --user dave --password --raw --result-file /tmp/ mysql-bin-changelog.000264
 ```

--stop-never option, the backup is “live” because mysqlbinlog stays connected to the server.


check the file
 ```bash
 ll /tmp/ | grep mysql

 file /tmp/mysql-bin-changelog.000264
 hexdump -C /tmp/mysql-bin-changelog.000264
 strings /tmp/mysql-bin-changelog.000264
 ```

## Debugging Meroxa

viewing logs
 ```bash
 meroxa connector logs connector491c59d0-f51e-4bce-ab60-880c4d6b7e44-994815
 ```

 or 

 ```bash
 meroxa function logs --debug function-228492 > meroxa.log
 ```