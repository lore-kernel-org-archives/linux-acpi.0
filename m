From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Whoever converted acpi to seq-file
Date: Sat, 18 Jan 2003 22:52:33 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030118215233.GA10033@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

...you completely messed up write support. IIRC you promised to fix
it, but did not do so.

I fixed write_trip_points completely, and attempted to fix others but
probably messed them up...
								Pavel


--- clean/drivers/acpi/processor.c	2003-01-17 23:12:20.000000000 +0100
+++ linux-swsusp/drivers/acpi/processor.c	2003-01-18 21:18:35.000000000 +0100
@@ -2273,7 +2273,7 @@
 			ACPI_PROCESSOR_FILE_PERFORMANCE));
 	else {
 		entry->proc_fops = &acpi_processor_perf_fops;
-		entry->write_proc = acpi_processor_write_performance;
+		entry->proc_fops->write = acpi_processor_write_performance;
 		entry->data = acpi_driver_data(device);
 	}
 #endif
@@ -2287,7 +2287,7 @@
 			ACPI_PROCESSOR_FILE_THROTTLING));
 	else {
 		entry->proc_fops = &acpi_processor_throttling_fops;
-		entry->write_proc = acpi_processor_write_throttling;
+		entry->proc_fops->write = acpi_processor_write_throttling;
 		entry->data = acpi_driver_data(device);
 	}
 
@@ -2300,7 +2300,7 @@
 			ACPI_PROCESSOR_FILE_LIMIT));
 	else {
 		entry->proc_fops = &acpi_processor_limit_fops;
-		entry->write_proc = acpi_processor_write_limit;
+		entry->proc_fops->write = acpi_processor_write_limit;
 		entry->data = acpi_driver_data(device);
 	}
 
--- clean/drivers/acpi/thermal.c	2003-01-17 23:09:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/thermal.c	2003-01-18 22:45:28.000000000 +0100
@@ -878,15 +878,16 @@
 acpi_thermal_write_trip_points (
         struct file		*file,
         const char		*buffer,
-        unsigned long		count,
-        void			*data)
+        size_t			count,
+        loff_t			*ppos)
 {
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *)m->private;
 	char			limit_string[25] = {'\0'};
 	int			critical, hot, passive, active0, active1;
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_trip_points");
 
 	if (!tz || (count > sizeof(limit_string) - 1)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
 		return_VALUE(-EINVAL);
@@ -1080,10 +1084,10 @@
 	if (!entry)
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 			"Unable to create '%s' fs entry\n",
-			ACPI_THERMAL_FILE_POLLING_FREQ));
+			ACPI_THERMAL_FILE_TRIP_POINTS));
 	else {
 		entry->proc_fops = &acpi_thermal_trip_fops;
-		entry->write_proc = acpi_thermal_write_trip_points;
+		entry->proc_fops->write = acpi_thermal_write_trip_points;
 		entry->data = acpi_driver_data(device);
 	}
 
@@ -1096,7 +1100,7 @@
 			ACPI_THERMAL_FILE_COOLING_MODE));
 	else {
 		entry->proc_fops = &acpi_thermal_cooling_fops;
-		entry->write_proc = acpi_thermal_write_cooling_mode;
+		entry->proc_fops->write = acpi_thermal_write_cooling_mode;
 		entry->data = acpi_driver_data(device);
 	}
 
@@ -1109,7 +1113,7 @@
 			ACPI_THERMAL_FILE_POLLING_FREQ));
 	else {
 		entry->proc_fops = &acpi_thermal_polling_fops;
-		entry->write_proc = acpi_thermal_write_polling;
+		entry->proc_fops->write = acpi_thermal_write_polling;
 		entry->data = acpi_driver_data(device);
 	}
 
--- clean/drivers/acpi/toshiba_acpi.c	2003-01-17 23:09:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/toshiba_acpi.c	2003-01-18 21:19:20.000000000 +0100
@@ -518,28 +518,28 @@
 		toshiba_proc_dir);
 	if (proc) {
 		proc->proc_fops = &toshiba_lcd_fops;
-		proc->write_proc = proc_write_lcd;
+		proc->proc_fops->write = proc_write_lcd;
 	}
 
 	proc = create_proc_entry(PROC_VIDEO, S_IFREG | S_IRUGO | S_IWUSR,
 		toshiba_proc_dir);
 	if (proc) {
 		proc->proc_fops = &toshiba_video_fops;
-		proc->write_proc = proc_write_video;
+		proc->proc_fops->write = proc_write_video;
 	}
 
 	proc = create_proc_entry(PROC_FAN, S_IFREG | S_IRUGO | S_IWUSR,
 		toshiba_proc_dir);
 	if (proc) {
 		proc->proc_fops = &toshiba_fan_fops;
-		proc->write_proc = proc_write_fan;
+		proc->proc_fops->write = proc_write_fan;
 	}
 
 	proc = create_proc_entry(PROC_KEYS, S_IFREG | S_IRUGO | S_IWUSR,
 		toshiba_proc_dir);
 	if (proc) {
 		proc->proc_fops = &toshiba_keys_fops;
-		proc->write_proc = proc_write_keys;
+		proc->proc_fops->write = proc_write_keys;
 	}
 
 	proc = create_proc_entry(PROC_VERSION, S_IFREG | S_IRUGO | S_IWUSR,

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
