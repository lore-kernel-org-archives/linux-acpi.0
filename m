From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Fix writing into /proc/acpi/thermal/*/trip_points
Date: Sat, 18 Jan 2003 22:53:42 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030118215342.GA10050@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

seq_file changes messed it up, please apply to fix at least
trip_points.
 
								Pavel


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
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
