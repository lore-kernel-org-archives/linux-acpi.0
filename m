From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Thermal managment broken
Date: Mon, 16 Sep 2002 18:36:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020916163600.GA11617@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Thermal managment forgets previous state, so it can never ever get to
slower state than T1.

Second patch allows user to set trip points. This is neccessary on XE3
-- BIOS claims passive cooling at 83C and critical at 100C. Yet it
powers down at ~85C. This allows user to override.

First is strict bugfix, please take. Second is needed, please take it,
too.

								Pavel 

--- clean/drivers/acpi/processor.c	2002-07-29 20:02:23.000000000 +0200
+++ linux/drivers/acpi/processor.c	2002-09-16 17:54:01.000000000 +0200
@@ -1468,6 +1468,9 @@
 	 * performance state.
 	 */
 
+	px = pr->limit.thermal.px;
+	tx = pr->limit.thermal.tx;
+
 	switch (type) {
 
 	case ACPI_PROCESSOR_LIMIT_NONE:
--- clean/drivers/acpi/thermal.c	2002-08-28 22:38:43.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2002-09-16 17:43:37.000000000 +0200
@@ -60,6 +60,7 @@
 #define ACPI_THERMAL_MAX_ACTIVE	10
 
 #define KELVIN_TO_CELSIUS(t)	((t-2732+5)/10)
+#define CELSIUS_TO_KELVIN(t)	((t+273)*10)
 
 static int acpi_thermal_add (struct acpi_device *device);
 static int acpi_thermal_remove (struct acpi_device *device, int type);
@@ -854,6 +868,46 @@
 
 
 static int
+acpi_thermal_write_trip_points (
+        struct file		*file,
+        const char		*buffer,
+        unsigned long		count,
+        void			*data)
+{
+	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+	char			limit_string[25] = {'\0'};
+	int			critical, hot, passive, active0, active1;
+
+	ACPI_FUNCTION_TRACE("acpi_thermal_write_trip_points");
+
+	if (!tz || (count > sizeof(limit_string) - 1)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
+		return_VALUE(-EINVAL);
+	}
+	
+	if (copy_from_user(limit_string, buffer, count)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
+		return_VALUE(-EFAULT);
+	}
+	
+	limit_string[count] = '\0';
+
+	if (sscanf(limit_string, "%d:%d:%d:%d:%d", &critical, &hot, &passive, &active0, &active1) != 5) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data format\n"));
+		return_VALUE(-EINVAL);
+	}
+
+	tz->trips.critical.temperature = CELSIUS_TO_KELVIN(critical);
+	tz->trips.hot.temperature = CELSIUS_TO_KELVIN(hot);
+	tz->trips.passive.temperature = CELSIUS_TO_KELVIN(passive);
+	tz->trips.active[0].temperature = CELSIUS_TO_KELVIN(active0);
+	tz->trips.active[1].temperature = CELSIUS_TO_KELVIN(active1);
+	
+	return_VALUE(count);
+}
+
+
+static int
 acpi_thermal_read_cooling_mode (
 	char			*page,
 	char			**start,
@@ -1042,15 +1096,16 @@
 		entry->data = acpi_driver_data(device);
 	}
 
-	/* 'trip_points' [R] */
+	/* 'trip_points' [R/W] */
 	entry = create_proc_entry(ACPI_THERMAL_FILE_TRIP_POINTS,
-		S_IRUGO, acpi_device_dir(device));
+		S_IFREG|S_IRUGO|S_IWUSR, acpi_device_dir(device));
 	if (!entry)
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 			"Unable to create '%s' fs entry\n",
 			ACPI_THERMAL_FILE_POLLING_FREQ));
 	else {
 		entry->read_proc = acpi_thermal_read_trip_points;
+		entry->write_proc = acpi_thermal_write_trip_points;
 		entry->data = acpi_driver_data(device);
 	}
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
