import os

def scythe_probe(marker):
    # make sure the environ is set
    try:
        directory = os.environ["SCYTHE_PROBE_DIR"]
    except:
        return

    # make sure the directory is valid
    if not os.path.isdir(directory):
        return

    filename = os.path.join(directory, marker + ".scythe_probe")
    if not os.path.exists(filename):
        #print(filename + " invalid")
        return
    
    os.utime(filename)


