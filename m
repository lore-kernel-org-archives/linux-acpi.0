From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: More seq-file fixes for /proc/acpi
Date: Thu, 13 Feb 2003 23:39:00 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030213223900.GA141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

More seq-file fixes. [This is not a dup ;-)] Toshiba maintainer,
please fix your stuff yourself. This should fix all /proc write
problems in acpi I know... Please apply,

							Pavel

--- clean/drivers/acpi/processor.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-02-13 23:16:28.000000000 +0100
@@ -1356,7 +1356,8 @@
         loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			state_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_processor_write_throttling");
@@ -1418,7 +1419,8 @@
 	loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			limit_string[25] = {'\0'};
 	int			px = 0;
 	int			tx = 0;
--- clean/drivers/acpi/thermal.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2003-02-13 23:17:37.000000000 +0100
@@ -946,11 +948,12 @@
 acpi_thermal_write_cooling_mode (
 	struct file		*file,
 	const char		*buffer,
-	size_t			count,
-	loff_t			*data)
+	unsigned long		count,
+	loff_t			*ppos)
 {
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			mode_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_cooling_mode");
@@ -1006,11 +1009,12 @@
 acpi_thermal_write_polling (
 	struct file		*file,
 	const char		*buffer,
-	size_t			count,
-	loff_t			*data)
+	unsigned long		count,
+	loff_t			*ppos)
 {
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			polling_string[12] = {'\0'};
 	int			seconds = 0;
 
--- clean/drivers/acpi/toshiba_acpi.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/toshiba_acpi.c	2003-02-13 23:17:16.000000000 +0100
@@ -519,6 +519,7 @@
 	if (proc) {
 		proc->proc_fops = &toshiba_lcd_fops;
 		proc->proc_fops->write = proc_write_lcd;
+#warning You need to fix up after converting to seq_file; see thermal.c for examples.
 	}
 
 	proc = create_proc_entry(PROC_VIDEO, S_IFREG | S_IRUGO | S_IWUSR,

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
