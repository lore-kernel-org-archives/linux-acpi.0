From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Fix thermal/cooling mode and thermal/polling frequency
Date: Fri, 24 Jan 2003 15:22:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030124142230.GA10768@elf.ucw.cz>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This should fix two more files in proc... Please apply,
								Pavel

--- clean/drivers/acpi/thermal.c	2003-01-17 23:09:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/thermal.c	2003-01-24 14:00:29.000000000 +0100
@@ -946,10 +950,11 @@
 	struct file		*file,
 	const char		*buffer,
 	unsigned long		count,
-	void			*data)
+	loff_t			*ppos)
 {
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			mode_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_cooling_mode");
@@ -1006,10 +1011,11 @@
 	struct file		*file,
 	const char		*buffer,
 	unsigned long		count,
-	void			*data)
+	loff_t			*ppos)
 {
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			polling_string[12] = {'\0'};
 	int			seconds = 0;
 


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
