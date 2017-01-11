/*
** Usage: `node test_node_probe`
**
** No test framework required.
**
*/

const fs = require("fs");
const scythe = require("./node_probe.js");

process.env.SCYTHE_PROBE_DIR = "/tmp";
scythe.probe("test-happy", function(err) {
  if (!err) {
    fs.stat("/tmp/test-happy.scythe_probe", (err, stats) => {
      if (!err) {
        console.log("test-happy " + stats.isFile());
        fs.unlink("/tmp/test-happy.scythe_probe", function(){});
      } else {
        console.log("test-happy " + err);
      }
    });
  } else {
    console.log("test-happy " + err);
  }
});

process.env.SCYTHE_PROBE_DIR = "/dev/null";
scythe.probe("test-not-dir", function(err) {
  console.log("test-not-dir " + (err && err.code == "ENOTDIR"));
});

process.env.SCYTHE_PROBE_DIR = "/";
scythe.probe("test-no-access", function(err) {
  console.log("test-no-access " + (err && err.code == "EACCES"));
});

process.env.SCYTHE_PROBE_DIR = undefined;
scythe.probe("test-no-env", function(err) {
  console.log("test-no-env " + (err && err.code == "ENOENT"));
});

