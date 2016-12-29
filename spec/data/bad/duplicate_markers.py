import sys
sys.path.append("../../../probes")

from python_probe import scythe_probe

if True:
    scythe_probe("marker0_py")

scythe_probe("marker0_py")
scythe_probe("marker1_py")
scythe_probe("marker1_py")

scythe_probe("marker2_py")
