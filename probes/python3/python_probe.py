import os

def scythe_probe(marker):
    try:
        directory = os.environ["SCYTHE_PROBE_DIR"]
    except:
        return

    if not os.path.isdir(directory):
        return

    filename = os.path.join(directory, marker + ".scythe_probe")
    if not os.path.exists(filename):
        return

    os.utime(filename)


