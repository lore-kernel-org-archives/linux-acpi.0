From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 9/9] ACPI thermal: make procfs I/F depend on
 CONFIG_ACPI_PROCFS
Date: Thu, 15 Jul 2010 10:46:44 +0800
Message-ID: <1279162004.4537.8522.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24435 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128Ab0GOCoj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 22:44:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Make ACPI thermal driver procfs I/F depend on CONFIG_ACPI_PROCFS.

Users should use /sys/class/thermal/ instead.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig   |    1 
 drivers/acpi/thermal.c |   86 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 33 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -37,10 +37,14 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#endif
+
 #include <linux/jiffies.h>
 #include <linux/kmod.h>
-#include <linux/seq_file.h>
 #include <linux/reboot.h>
 #include <linux/device.h>
 #include <asm/uaccess.h>
@@ -102,16 +106,6 @@ static int acpi_thermal_add(struct acpi_
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_resume(struct acpi_device *device);
 static void acpi_thermal_notify(struct acpi_device *device, u32 event);
-static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
-static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
-static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
-static int acpi_thermal_cooling_open_fs(struct inode *inode, struct file *file);
-static ssize_t acpi_thermal_write_cooling_mode(struct file *,
-					       const char __user *, size_t,
-					       loff_t *);
-static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file);
-static ssize_t acpi_thermal_write_polling(struct file *, const char __user *,
-					  size_t, loff_t *);
 
 static const struct acpi_device_id  thermal_device_ids[] = {
 	{ACPI_THERMAL_HID, 0},
@@ -201,6 +195,18 @@ struct acpi_thermal {
 	struct mutex lock;
 };
 
+#ifdef CONFIG_ACPI_PROCFS
+static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
+static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
+static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
+static int acpi_thermal_cooling_open_fs(struct inode *inode, struct file *file);
+static ssize_t acpi_thermal_write_cooling_mode(struct file *,
+					       const char __user *, size_t,
+					       loff_t *);
+static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file);
+static ssize_t acpi_thermal_write_polling(struct file *, const char __user *,
+					  size_t, loff_t *);
+
 static const struct file_operations acpi_thermal_state_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_thermal_state_open_fs,
@@ -242,6 +248,7 @@ static const struct file_operations acpi
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif /* CONFIG_ACPI_PROCFS*/
 
 /* --------------------------------------------------------------------------
                              Thermal Zone Management
@@ -287,26 +294,6 @@ static int acpi_thermal_get_polling_freq
 	return 0;
 }
 
-static int acpi_thermal_set_polling(struct acpi_thermal *tz, int seconds)
-{
-
-	if (!tz)
-		return -EINVAL;
-
-	tz->polling_frequency = seconds * 10;	/* Convert value to deci-seconds */
-
-	tz->thermal_zone->polling_delay = seconds * 1000;
-
-	if (tz->tz_enabled)
-		thermal_zone_device_update(tz->thermal_zone);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Polling frequency set to %lu seconds\n",
-			  tz->polling_frequency/10));
-
-	return 0;
-}
-
 static int acpi_thermal_set_cooling_mode(struct acpi_thermal *tz, int mode)
 {
 	acpi_status status = AE_OK;
@@ -973,7 +960,7 @@ static void acpi_thermal_unregister_ther
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
-
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_thermal_dir;
 
 static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
@@ -1187,6 +1174,26 @@ static int acpi_thermal_polling_open_fs(
 			   PDE(inode)->data);
 }
 
+static int acpi_thermal_set_polling(struct acpi_thermal *tz, int seconds)
+{
+	if (!tz)
+		return -EINVAL;
+
+	/* Convert value to deci-seconds */
+	tz->polling_frequency = seconds * 10;
+
+	tz->thermal_zone->polling_delay = seconds * 1000;
+
+	if (tz->tz_enabled)
+		thermal_zone_device_update(tz->thermal_zone);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "Polling frequency set to %lu seconds\n",
+			  tz->polling_frequency/10));
+
+	return 0;
+}
+
 static ssize_t
 acpi_thermal_write_polling(struct file *file,
 			   const char __user * buffer,
@@ -1295,7 +1302,13 @@ static int acpi_thermal_remove_fs(struct
 
 	return 0;
 }
-
+#else
+static inline int acpi_thermal_add_fs(struct acpi_device *device) { return 0; }
+static inline int acpi_thermal_remove_fs(struct acpi_device *device)
+{
+	return 0;
+}
+#endif /* CONFIG_ACPI_PROCFS */
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -1566,13 +1579,18 @@ static int __init acpi_thermal_init(void
 		printk(KERN_NOTICE "ACPI: thermal control disabled\n");
 		return -ENODEV;
 	}
+
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
 	if (!acpi_thermal_dir)
 		return -ENODEV;
+#endif
 
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
 	if (result < 0) {
+#ifdef CONFIG_ACPI_PROCFS
 		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
+#endif
 		return -ENODEV;
 	}
 
@@ -1584,7 +1602,9 @@ static void __exit acpi_thermal_exit(voi
 
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
+#endif
 
 	return;
 }
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -57,6 +57,7 @@ config ACPI_PROCFS
 	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
 		cooling_device*/*)
 	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
+	  /proc/acpi/thermal_zone/*/* (/sys/class/thermal/)
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.
 


