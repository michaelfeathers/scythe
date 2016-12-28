package scythe;

import static org.junit.Assert.*;
import static scythe.Probe.*;

import java.io.File;

import org.junit.Ignore;
import org.junit.Test;

public class ProbeTest {

	private final String EXISTING_MARKER = "java_existing";

	private String path(String marker) {
		 String path = System.getenv("SCYTHE_PROBE_DIR");
		 File file = new File(path, marker + ".scythe_probe");
		 return file.getAbsolutePath();
	}
	
	@Test
	public void environmentSet() {
		assertNotNull(System.getenv("SCYTHE_PROBE_DIR"));
	}
	
	@Test 
	public void testingMarkerExists() {
		assertTrue(new File(path(EXISTING_MARKER)).exists());
		
	}
	
	@Test
	public void doesNotTouchOnNonExisting() {
		String marker = "java_not_existing";
		scythe_probe(marker);
		
		assertFalse(new File(path(marker)).exists());
	}

	@Test
	public void touchesOnExisting() {
		long oldMarkerTime = new File(path(EXISTING_MARKER)).lastModified();
		scythe_probe(EXISTING_MARKER);
		
		long newMarkerTime = new File(path(EXISTING_MARKER)).lastModified();
	
		assertTrue(newMarkerTime > oldMarkerTime);
	}

}
