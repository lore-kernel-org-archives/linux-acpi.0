From: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Subject: [patch] remove null-ifiers
Date: Wed, 14 Jan 2004 08:15:10 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1AgkrW-00080w-00@jaguar.mkp.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

The included patch removes a number of NULL-ilizers from the ACPI code
resulting in variables being put in the data segment instead of the bss
segment.

Patch is relative to Andrew's 2.6.1-mm3 patch.

Cheers,
Jes

diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/ac.c linux-2.6.1-mm3/drivers/acpi/ac.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/ac.c	Wed Dec 17 18:58:47 2003
+++ linux-2.6.1-mm3/drivers/acpi/ac.c	Wed Jan 14 04:55:10 2004
@@ -108,7 +108,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ac_dir = NULL;
+struct proc_dir_entry		*acpi_ac_dir;
 
 int acpi_ac_seq_show(struct seq_file *seq, void *offset)
 {
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/asus_acpi.c linux-2.6.1-mm3/drivers/acpi/asus_acpi.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/asus_acpi.c	Wed Dec 17 18:58:39 2003
+++ linux-2.6.1-mm3/drivers/acpi/asus_acpi.c	Wed Jan 14 05:00:01 2004
@@ -73,8 +73,8 @@
 MODULE_LICENSE("GPL");
 
 
-static uid_t asus_uid = 0;
-static gid_t asus_gid = 0;
+static uid_t asus_uid;
+static gid_t asus_gid;
 MODULE_PARM(asus_uid, "i");
 MODULE_PARM_DESC(uid, "UID for entries in /proc/acpi/asus.\n");
 MODULE_PARM(asus_gid, "i");
@@ -192,14 +192,14 @@
 };
 
 /* procdir we use */
-static struct proc_dir_entry *asus_proc_dir = NULL;
+static struct proc_dir_entry *asus_proc_dir;
 
 /*
  * This header is made available to allow proper configuration given model,
  * revision number , ... this info cannot go in struct asus_hotk because it is
  * available before the hotk
  */
-static struct acpi_table_header *asus_info = NULL;
+static struct acpi_table_header *asus_info;
 
 /*
  * The hotkey driver declaration
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/battery.c linux-2.6.1-mm3/drivers/acpi/battery.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/battery.c	Wed Dec 17 18:59:17 2003
+++ linux-2.6.1-mm3/drivers/acpi/battery.c	Wed Jan 14 04:56:10 2004
@@ -340,7 +340,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_battery_dir = NULL;
+struct proc_dir_entry		*acpi_battery_dir;
 
 static int
 acpi_battery_read_info (
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/button.c linux-2.6.1-mm3/drivers/acpi/button.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/button.c	Wed Dec 17 18:58:06 2003
+++ linux-2.6.1-mm3/drivers/acpi/button.c	Wed Jan 14 04:56:39 2004
@@ -107,7 +107,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-static struct proc_dir_entry	*acpi_button_dir = NULL;
+static struct proc_dir_entry	*acpi_button_dir;
 
 static int acpi_button_info_seq_show(struct seq_file *seq, void *offset)
 {
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/ec.c linux-2.6.1-mm3/drivers/acpi/ec.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/ec.c	Wed Dec 17 18:58:56 2003
+++ linux-2.6.1-mm3/drivers/acpi/ec.c	Wed Jan 14 04:57:01 2004
@@ -475,7 +475,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ec_dir = NULL;
+struct proc_dir_entry		*acpi_ec_dir;
 
 
 static int
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/fan.c linux-2.6.1-mm3/drivers/acpi/fan.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/fan.c	Wed Dec 17 18:58:07 2003
+++ linux-2.6.1-mm3/drivers/acpi/fan.c	Wed Jan 14 04:57:17 2004
@@ -71,7 +71,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_fan_dir = NULL;
+struct proc_dir_entry		*acpi_fan_dir;
 
 
 static int
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/osl.c linux-2.6.1-mm3/drivers/acpi/osl.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/osl.c	Wed Jan 14 02:59:49 2004
+++ linux-2.6.1-mm3/drivers/acpi/osl.c	Wed Jan 14 05:00:25 2004
@@ -59,13 +59,13 @@
 #ifdef ENABLE_DEBUGGER
 #include <linux/kdb.h>
 /* stuff for debugger support */
-int acpi_in_debugger = 0;
+int acpi_in_debugger;
 extern char line_buf[80];
 #endif /*ENABLE_DEBUGGER*/
 
-static int acpi_irq_irq = 0;
-static OSD_HANDLER acpi_irq_handler = NULL;
-static void *acpi_irq_context = NULL;
+static int acpi_irq_irq;
+static OSD_HANDLER acpi_irq_handler;
+static void *acpi_irq_context;
 
 acpi_status
 acpi_os_initialize(void)
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/power.c linux-2.6.1-mm3/drivers/acpi/power.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/power.c	Wed Dec 17 18:58:56 2003
+++ linux-2.6.1-mm3/drivers/acpi/power.c	Wed Jan 14 04:58:13 2004
@@ -387,7 +387,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_power_dir = NULL;
+struct proc_dir_entry		*acpi_power_dir;
 
 static int acpi_power_seq_show(struct seq_file *seq, void *offset)
 {
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/processor.c linux-2.6.1-mm3/drivers/acpi/processor.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/processor.c	Wed Dec 17 18:59:05 2003
+++ linux-2.6.1-mm3/drivers/acpi/processor.c	Wed Jan 14 04:58:27 2004
@@ -138,7 +138,7 @@
 
 static struct acpi_processor	*processors[NR_CPUS];
 static struct acpi_processor_errata errata;
-static void (*pm_idle_save)(void) = NULL;
+static void (*pm_idle_save)(void);
 
 
 /* --------------------------------------------------------------------------
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/thermal.c linux-2.6.1-mm3/drivers/acpi/thermal.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/thermal.c	Wed Jan 14 02:59:49 2004
+++ linux-2.6.1-mm3/drivers/acpi/thermal.c	Wed Jan 14 04:59:18 2004
@@ -74,7 +74,7 @@
 MODULE_DESCRIPTION(ACPI_THERMAL_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-static int tzp = 0;
+static int tzp;
 MODULE_PARM(tzp, "i");
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
@@ -766,7 +766,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_thermal_dir = NULL;
+struct proc_dir_entry		*acpi_thermal_dir;
 
 static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
 {
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/toshiba_acpi.c linux-2.6.1-mm3/drivers/acpi/toshiba_acpi.c
--- orig/linux-2.6.1-mm3-boot/drivers/acpi/toshiba_acpi.c	Wed Dec 17 18:58:07 2003
+++ linux-2.6.1-mm3/drivers/acpi/toshiba_acpi.c	Wed Jan 14 04:59:33 2004
@@ -215,7 +215,7 @@
 	return status;
 }
 
-static struct proc_dir_entry*	toshiba_proc_dir = NULL;
+static struct proc_dir_entry*	toshiba_proc_dir;
 static int			force_fan;
 static int			last_key_event;
 static int			key_event_valid;


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
