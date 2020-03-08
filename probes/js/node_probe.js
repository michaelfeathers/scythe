const process = require("process");
const path = require("path");
const fs = require("fs");

/*
** Updates the access and modified times of the probe file for this marker.
** Async. No return value. Any errors swallowed and short-circuit as soon as possible.
** The `callback` argument is optional, and recommended only for verification / testing.
*/
module.exports.probe = function(marker, callback) {
  const dir = process.env.SCYTHE_PROBE_DIR;
  if (!callback) callback = function(){};
  fs.stat(dir, (err, stats) => {
    if (err == null && stats && stats.isDirectory()) fs.open(probeFileName(dir, marker), 'a', (err, fd) => {
      if (err == null)
        fs.futimes(fd, posixNow(), posixNow(), callback(null));
      else {
        callback(err);
      }
    });
    else {
      if (stats && !stats.isDirectory()) {
        err = new Error();
        err.code = 'ENOTDIR';
      }
      callback(err);
    }
  });
}

/*
** Returns the full path of the probe file for this marker
*/
function probeFileName(dir, marker) {
  return path.join(dir, marker + ".scythe_probe");
}

/*
** Posix timestamps are *seconds* since epoch.
** `Date.now()` returns milliseconds. Zero-shift truncates float to integer.
*/
function posixNow() {
  return (Date.now() / 1000) >> 0;
}
