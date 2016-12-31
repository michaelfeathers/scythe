using System;
using System.IO;

namespace Scythe
{
    public class Probe
    {
        public static void Scythe_Probe(string marker)
        {
            try
            {
                var folder = Environment.GetEnvironmentVariable("SCYTHE_PROBE_DIR");
                if (!Directory.Exists(folder))
                {
                    if (string.IsNullOrWhiteSpace(folder))
                    {
                        return;
                    }
                    else
                    {
                        Directory.CreateDirectory(folder);
                    }
                }

                var filename = marker + ".scythe_probe";
                var path = Path.Combine(folder, filename);

                if (File.Exists(path))
                {
                    File.SetLastWriteTime(path, DateTime.UtcNow);
                }
                else
                {
                    using (var f = File.Create(path))
                    {
                        // intentionally left blank
                    }
                }
            }
            catch
            {
                // intentionally left blank
            }
        }
    }
}