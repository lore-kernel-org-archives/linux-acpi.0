From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/20] ACPI thermal: make procfs I/F depend on
 CONFIG_ACPI_PROCFS
Date: Sun, 15 Aug 2010 01:23:23 -0400
Message-ID: <43d9f87b79804f2d75d9d8a81c862b179f055a15.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57583 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0HOFaJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:30:09 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600HN2HY5RHB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:30:09 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Mark the ACPI thermal procfs I/F deprecated, because /sys/class/thermal/
is already available and has been working for years w/o any problem.

The ACPI thermal procfs I/F will be removed in 2.6.37.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig   |    1 +
 drivers/acpi/thermal.c |   86 +++++++++++++++++++++++++++++------------------
 2 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 354e613..5ed51b3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -57,6 +57,7 @@ config ACPI_PROCFS
 	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
 		cooling_device*/*)
 	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
+	  /proc/acpi/thermal_zone/*/* (/sys/class/thermal/)
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index efad1f3..2f8f171 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
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
@@ -102,16 +106,6 @@ static int acpi_thermal_add(struct acpi_device *device);
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
@@ -242,6 +248,7 @@ static const struct file_operations acpi_thermal_polling_fops = {
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif /* CONFIG_ACPI_PROCFS*/
 
 /* --------------------------------------------------------------------------
                              Thermal Zone Management
@@ -287,26 +294,6 @@ static int acpi_thermal_get_polling_frequency(struct acpi_thermal *tz)
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
@@ -973,7 +960,7 @@ static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
-
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_thermal_dir;
 
 static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
@@ -1187,6 +1174,26 @@ static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file)
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
@@ -1295,7 +1302,13 @@ static int acpi_thermal_remove_fs(struct acpi_device *device)
 
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
@@ -1566,13 +1579,18 @@ static int __init acpi_thermal_init(void)
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
 
@@ -1584,7 +1602,9 @@ static void __exit acpi_thermal_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
+#endif
 
 	return;
 }
-- 
1.7.2.1.95.g3d045

