import traceback
from lambda_config import *
import dbt.main as dbt_main


def handler(event, context):
    # dbt_main.log_manager.disable()
    dbt_main.log_manager._file_handler.disabled = True
    dbt_args = ["--quiet", "run", "--profiles-dir", "profile", "--target", "prod"]

    try:
        results, succeeded = dbt_main.handle_and_check(dbt_args)
    except Exception as e:
        traceback.print_exc()
        results = None
        succeeded = False
        message = "ERROR"
    else:
        message = "OK"
    return {
        "statusCode": 200,
        "body": {"message": message, "results": str(results), "succeeded": succeeded},
    }

handler(None, None)