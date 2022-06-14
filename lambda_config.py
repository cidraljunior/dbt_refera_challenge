import queue
import threading
import multiprocessing.dummy
from concurrent.futures import ThreadPoolExecutor
import dbt.flags as dbt_flags


class CustomThreadPool:
    def __init__(self, num_threads):
        self.pool = ThreadPoolExecutor(max_workers=num_threads)

    def apply_async(self, func, args, callback):
        def future_callback(fut):
            return callback(fut.result())

        self.pool.submit(func, *args).add_done_callback(future_callback)

    def close(self):
        pass

    def join(self):
        self.pool.shutdown(wait=True)


multiprocessing.dummy.Pool = CustomThreadPool

class ThreadedContext:
    Process = threading.Thread
    Lock = threading.Lock
    RLock = threading.RLock
    Queue = queue.Queue


def get_threaded_context():
    return ThreadedContext()


dbt_flags._get_context = get_threaded_context
dbt_flags.MP_CONTEXT = ThreadedContext()