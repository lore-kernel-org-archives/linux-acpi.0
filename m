From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: More /proc write fixes
Date: Tue, 11 Feb 2003 19:47:14 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030211184714.GA24991@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This fixes writing to some more /proc entries. Please apply,

								Pavel

--- clean/drivers/acpi/thermal.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2003-02-11 17:51:08.000000000 +0100
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
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
