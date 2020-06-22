using System;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Scythe_CSharp_Tests
{
    [TestClass]
    public class Tests_Probe
    {
        private static readonly string ENVIRONMENT_VARIABLE_NAME = "SCYTHE_PROBE_DIR";
        private static readonly string TEST_FOLDER = @"L:\Scythe_Probes";
        private static readonly string MARKER = "csharp_marker";

        [TestInitialize]
        public void Init()
        {
            Environment.SetEnvironmentVariable(ENVIRONMENT_VARIABLE_NAME, TEST_FOLDER);
        }

        [TestCleanup]
        public void CleanUp()
        {
            var folder = Environment.GetEnvironmentVariable("SCYTHE_PROBE_DIR");
            var filename = MARKER + ".scythe_probe";
            var path = Path.Combine(folder, filename);
            File.Delete(path);
        }

        [TestMethod]
        public void Test_IsEnvironmentVariableSetToValidPath()
        {
            var folder = Environment.GetEnvironmentVariable(ENVIRONMENT_VARIABLE_NAME);

            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);

            Assert.IsTrue(Directory.Exists(folder));
        }

        [TestMethod]
        public void Test_NewMarker()
        {
            Scythe.Probe.Scythe_Probe(MARKER);

            var folder = Environment.GetEnvironmentVariable("SCYTHE_PROBE_DIR");
            var filename = MARKER + ".scythe_probe";
            var path = Path.Combine(folder, filename);
            Assert.IsTrue(File.Exists(path));
        }

        [TestMethod]
        public void Test_ExistingMarker()
        {
            Scythe.Probe.Scythe_Probe(MARKER);

            var folder = Environment.GetEnvironmentVariable("SCYTHE_PROBE_DIR");
            var filename = MARKER + ".scythe_probe";
            var path = Path.Combine(folder, filename);
            Assert.IsTrue(File.Exists(path));

            var tlaOnCreate = File.GetLastWriteTimeUtc(path);

            System.Threading.Thread.Sleep(3000);

            Scythe.Probe.Scythe_Probe(MARKER);

            var tlaAfterUpdate = File.GetLastWriteTimeUtc(path);

            Assert.IsTrue(tlaOnCreate < tlaAfterUpdate);
        }
    }
}