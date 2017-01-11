/*
** Usage: `node test_node_probe`
**
** No test framework required.
**
** Due to the async and non-determinant nature of probe file updates, we impose an arbitrary delay to verify expected behaviour.
** This could be made deterministic with a mock file system, but that is deemed to be not valuable at time of writing.
*/

const fs = require("fs");
const scythe = require("./node_probe.js");
var stats;

process.env.SCYTHE_PROBE_DIR = "/tmp";
scythe.probe("test-happy");

process.env.SCYTHE_PROBE_DIR = "/";
scythe.probe("test-no-access");

process.env.SCYTHE_PROBE_DIR = "/dev/null";
scythe.probe("test-not-dir");

process.env.SCYTHE_PROBE_DIR = undefined;
scythe.probe("test-no-env");


const execs = require('child_process').execSync;
execs("sleep 5");

stats = fs.stat("/tmp/test-happy.scythe_probe", (err, stats) => {
  console.log("test-happy " + stats.isFile());
});

stats = fs.stat("/test-no-access.scythe_probe", (err, stats) => {
  console.log("test-no-access " + (err.code == "ENOENT"));
});

stats = fs.stat("/dev/null/test-not-dir.scythe_probe", (err, stats) => {
  console.log("test-not-dir " + (err.code == "ENOTDIR"));
});

stats = fs.stat("test-no-env.scythe_probe", (err, stats) => {
  console.log("test-no-env " + (err.code == "ENOENT"));
});
