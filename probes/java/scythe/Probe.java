package scythe;

import java.io.File;

public class Probe {
	
	public static void scythe_probe(String marker) {
		try {
		 String path = System.getenv("SCYTHE_PROBE_DIR");
		 File dir = new File(path);
		 
		 if (!dir.exists() || !dir.isDirectory())
			 return;
		 
		 File file = new File(dir.getPath(), marker + ".scythe_probe");
		 
		 if (file.exists())
			 return;
		 
		 file.setLastModified(System.currentTimeMillis());
		 
		} catch(Exception e) {
		
		}
		 
	}
}
