#!/usr/bin/env python

import time
from multiprocessing import Process, Queue
import subprocess
import os
import signal
from datetime import datetime


def checkpid(pid):
    try:
        os.kill(pid, 0)
    except OSError:
        return False
    else:
        return True


def runcmd(cmd, secs, queue):
    time.sleep(secs)
    dt = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    print("{} Executing {}".format(dt, cmd))
    start = time.time()
    result = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    queue.put([cmd, result.pid, start])


class GracefulKiller:
    kill_now = False

    def __init__(self):
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)

    def exit_gracefully(self, signum, frame):
        self.kill_now = True


if __name__ == "__main__":
    cmds = ["rsync -avAEWSlHh /mnt/primary/1/* /mnt/backup/1/ --no-compress --info=progress2 --delete --delete-during",
            "rsync -avAEWSlHh /mnt/primary/2/* /mnt/backup/2/ --exclude='logs' --no-compress --info=progress2 --delete --delete-during"]

    ### run interval secs
    runInterval = 1800
    queue = Queue()
    killer = GracefulKiller()

    for cmd in cmds:
        Process(target=runcmd, args=(cmd, 0, queue,)).start()

    while not killer.kill_now:
        time.sleep(5)
        if not queue.empty():
            val = queue.get()
            # print(val)
            if not checkpid(val[1]):
                end = time.time()
                execTime = int(end - val[2])
                print("{} execution time {} seconds".format(val[0], execTime))
                if execTime > runInterval:
                    Process(target=runcmd, args=(val[0], 0, queue,)).start()
                else:
                    sleepsecs = runInterval - int(end - val[2])
                    Process(target=runcmd, args=(val[0], sleepsecs, queue,)).start()
            else:
                queue.put(val)

    while not queue.empty():
        val = queue.get()
        try:
            os.kill(val[1], signal.SIGKILL)
        except OSError:
            print("pid {} not found".format(val[1]))

    print("Process exited gracefully")

