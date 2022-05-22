# snowflake

export SNOWFLAKE_PRIVATE_KEY=$(cat ~/.ssh/snowflake_tf_snow_key.p8)

meroxa resource create snowflake \ 
  --type snowflakedb \
  --url snowflake://ns39773.ap-southeast-2.snowflakecomputing.com/meroxa_db/stream_data \
  --username MEROXA_USER \
  --password $SNOWFLAKE_PRIVATE_KEY


## test_mysql_rds

export MYSQL_USER=dave
export MYSQL_PASS=<CHANGEME>
export MYSQL_URL="terraform-XXXXX.ap-southeast-2.rds.amazonaws.com"
export MYSQL_PORT="3306"
export MYSQL_DB=mydb

meroxa resource create test_mysql_rds \
--type mysql \
--url mysql://$MYSQL_USER:$MYSQL_PASS@$MYSQL_URL:$MYSQL_PORT/$MYSQL_DB


# check binlong

mysqlbinlog --read-from-remote-server \
--host $MYSQL_URL \
--port $MYSQL_PORT \
--user $MYSQL_USER \
--password \
--raw \
--result-file /tmp/ \
binlog.00098