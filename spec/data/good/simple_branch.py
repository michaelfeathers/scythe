import sys
sys.path.append("../../../probes")

from python_probe import scythe_probe

if 1 * 2 == 2:
    scythe_probe("marker0_py")
else:
    scythe_probe("marker1_py")
