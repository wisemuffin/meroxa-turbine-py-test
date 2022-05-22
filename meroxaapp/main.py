import hashlib
import logging
import sys
import typing as t
import json

from turbine.runtime import Record, Runtime

logging.basicConfig(level=logging.INFO)

def passthrough(records: t.List[Record]) -> t.List[Record]:
    updated = []
    logging.info(f"processing {len(records)} record(s)")
    for record in records:
        logging.info(f"input: {record}")
        try:
            record_value_from_json = json.loads(record.value)
            new_record = Record(
                key=record.key,
                value=record_value_from_json,
                timestamp=record.timestamp,
            )
            logging.info(f"output: {new_record}")
            updated.append(new_record)
        except Exception as e:
            print("Error occurred while parsing records: " + str(e))
            new_record = Record(
                key=record.key,
                value=record_value_from_json,
                timestamp=record.timestamp,
            )
            updated.append(new_record)
            logging.info(f"output: {new_record}")
    return updated

# def anonymize(records: t.List[Record]) -> t.List[Record]:
#     updated = []
#     logging.info(f"processing {len(records)} record(s)")
#     for record in records:
#         logging.info(f"input: {record}")
#         try:
#             record_value_from_json = json.loads(record.value)
#             hashed_email = hashlib.sha256(
#                 record_value_from_json["payload"]["customer_email"].encode("utf-8")
#             ).hexdigest()
#             record_value_from_json["payload"]["customer_email"] = hashed_email
#             new_record = Record(
#                 key=record.key,
#                 value=record_value_from_json,
#                 timestamp=record.timestamp,
#             )
#             logging.info(f"output: {new_record}")
#             updated.append(new_record)
#         except Exception as e:
#             print("Error occurred while parsing records: " + str(e))
#             new_record = Record(
#                 key=record.key,
#                 value=record_value_from_json,
#                 timestamp=record.timestamp,
#             )
#             updated.append(new_record)
#             logging.info(f"output: {new_record}")
#     return updated


class App:
    @staticmethod
    async def run(turbine: Runtime):
        try:
            # To configure your data stores as resources on the Meroxa Platform
            # use the Meroxa Dashboard, CLI, or Meroxa Terraform Provider.
            # For more details refer to: https://docs.meroxa.com/

            # Identify an upstream data store for your data app
            # with the `resources` function.
            # Replace `source_name` with the resource name the
            # data store was configured with on the Meroxa platform.
            source = await turbine.resources("test_mysql_rds")

            # Specify which upstream records to pull
            # with the `records` function.
            # Replace `collection_name` with a table, collection,
            # or bucket name in your data store.
            # If you need additional connector configurations, replace '{}'
            # with the key and value, i.e. {"incrementing.field.name": "id"}
            records = await source.records("tasks", {})
            

            # Specify which secrets in environment variables should be passed
            # into the Process.
            # Replace 'PWD' with the name of the environment variable.
            # turbine.register_secrets("PWD")

            # Specify what code to execute against upstream records
            # with the `process` function.
            # Replace `anonymize` with the name of your function code.
            passedthrough = await turbine.process(records, passthrough)

            # Identify a downstream data store for your data app
            # with the `resources` function.
            # Replace `destination_name` with the resource name the
            # data store was configured with on the Meroxa platform.
            destination_db = await turbine.resources("snowflake")

            # Specify where to write records downstream
            # using the `write` function.
            # Replace `collection_archive` with a table, collection,
            # or bucket name in your data store.
            # If you need additional connector configurations, replace '{}'
            # with the key and value, i.e. {"behavior.on.null.values": "ignore"}
            await destination_db.write(passedthrough, "tasks2", {})
        except Exception as e:
            print(e, file=sys.stderr)
