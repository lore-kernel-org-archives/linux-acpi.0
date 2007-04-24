From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/9] ACPI: thinkpad-acpi: register with the device model
Date: Tue, 24 Apr 2007 11:48:12 -0300
Message-ID: <11774261003259-git-send-email-hmh@hmh.eng.br>
References: <11774261003184-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56694 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754092AbXDXOs1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 10:48:27 -0400
In-Reply-To: <11774261003184-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Register thinkpad-acpi platform driver and platform device for the device
model.  Also register the platform device with the hwmon class.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |   40 ++++++++++++++++++++++++----
 drivers/misc/Kconfig            |    1 +
 drivers/misc/thinkpad_acpi.c    |   54 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/thinkpad_acpi.h    |    8 ++++++
 4 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 1a42b77..0e4e053 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
                             Version 0.14
-                          March 26th, 2007
+                          April 21st, 2007
 
                Borislav Deianov <borislav@users.sf.net>
 	     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
@@ -67,11 +67,39 @@ thinkpad-specific bay functionality.
 Features
 --------
 
-The driver creates the /proc/acpi/ibm directory. There is a file under
-that directory for each feature described below. Note that while the
-driver is still in the alpha stage, the exact proc file format and
-commands supported by the various features is guaranteed to change
-frequently.
+The driver exports two different interfaces to userspace, which can be
+used to access the features it provides.  One is a legacy procfs-based
+interface, which will be removed at some time in the distant future.
+The other is a new sysfs-based interface which is not complete yet.
+
+The procfs interface creates the /proc/acpi/ibm directory.  There is a
+file under that directory for each feature it supports.  The procfs
+interface is mostly frozen, and will change very little if at all: it
+will not be extended to add any new functionality in the driver, instead
+all new functionality will be implemented on the sysfs interface.
+
+The sysfs interface tries to blend in the generic Linux sysfs subsystems
+and classes as much as possible.  Since some of these subsystems are not
+yet ready or stabilized, it is expected that this interface will change,
+and any and all userspace programs must deal with it.
+
+
+Notes about the sysfs interface:
+
+Unlike what was done with the procfs interface, correctness when talking
+to the sysfs interfaces will be enforced, as will correctness in the
+thinkpad-acpi's implementation of sysfs interfaces.
+
+Also, any bugs in the thinkpad-acpi sysfs driver code or in the
+thinkpad-acpi's implementation of the sysfs interfaces will be fixed for
+maximum correctness, even if that means changing an interface in
+non-compatible ways.  As these interfaces mature both in the kernel and
+in thinkpad-acpi, such changes should become quite rare.
+
+Applications interfacing to the thinkpad-acpi sysfs interfaces must
+follow all sysfs guidelines and correctly process all errors (the sysfs
+interface makes extensive use of errors).  File descriptors and open /
+close operations to the sysfs inodes must also be properly implemented.
 
 Driver version -- /proc/acpi/ibm/driver
 ---------------------------------------
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 44e4c8f..445c4b1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -126,6 +126,7 @@ config THINKPAD_ACPI
 	tristate "ThinkPad ACPI Laptop Extras"
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
+	select HWMON
 	---help---
 	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9b4eea4..e47eaf7 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -477,6 +477,25 @@ static char *next_cmd(char **cmds)
 /****************************************************************************
  ****************************************************************************
  *
+ * Device model: hwmon and platform
+ *
+ ****************************************************************************
+ ****************************************************************************/
+
+static struct platform_device *tpacpi_pdev = NULL;
+static struct class_device *tpacpi_hwmon = NULL;
+
+static struct platform_driver tpacpi_pdriver = {
+	.driver = {
+		.name = IBM_DRVR_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+
+/****************************************************************************
+ ****************************************************************************
+ *
  * Subdrivers
  *
  ****************************************************************************
@@ -3225,10 +3244,12 @@ static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
 
+	/* Driver-level probe */
 	ret = probe_for_thinkpad();
 	if (ret)
 		return ret;
 
+	/* Driver initialization */
 	ibm_thinkpad_ec_found = check_dmi_for_ec();
 	IBM_ACPIHANDLE_INIT(ecrd);
 	IBM_ACPIHANDLE_INIT(ecwr);
@@ -3241,6 +3262,31 @@ static int __init thinkpad_acpi_module_init(void)
 	}
 	proc_dir->owner = THIS_MODULE;
 
+	ret = platform_driver_register(&tpacpi_pdriver);
+	if (ret) {
+		printk(IBM_ERR "unable to register platform driver\n");
+		thinkpad_acpi_module_exit();
+		return ret;
+	}
+
+	/* Device initialization */
+	tpacpi_pdev = platform_device_register_simple(IBM_DRVR_NAME, -1,
+							NULL, 0);
+	if (IS_ERR(tpacpi_pdev)) {
+		ret = PTR_ERR(tpacpi_pdev);
+		tpacpi_pdev = NULL;
+		printk(IBM_ERR "unable to register platform device\n");
+		thinkpad_acpi_module_exit();
+		return ret;
+	}
+	tpacpi_hwmon = hwmon_device_register(&tpacpi_pdev->dev);
+	if (IS_ERR(tpacpi_hwmon)) {
+		ret = PTR_ERR(tpacpi_hwmon);
+		tpacpi_hwmon = NULL;
+		printk(IBM_ERR "unable to register hwmon device\n");
+		thinkpad_acpi_module_exit();
+		return ret;
+	}
 	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
 		ret = ibm_init(&ibms_init[i]);
 		if (ret >= 0 && *ibms_init[i].param)
@@ -3266,6 +3312,14 @@ static void thinkpad_acpi_module_exit(void)
 
 	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
 
+	if (tpacpi_hwmon)
+		hwmon_device_unregister(tpacpi_hwmon);
+
+	if (tpacpi_pdev)
+		platform_device_unregister(tpacpi_pdev);
+
+	platform_driver_unregister(&tpacpi_pdriver);
+
 	if (proc_dir)
 		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 6432b28..fea5809 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -34,6 +34,8 @@
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
 #include <linux/fb.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -56,6 +58,7 @@
 
 #define IBM_PROC_DIR "ibm"
 #define IBM_ACPI_EVENT_PREFIX "ibm"
+#define IBM_DRVR_NAME IBM_FILE
 
 #define IBM_LOG IBM_FILE ": "
 #define IBM_ERR	   KERN_ERR    IBM_LOG
@@ -130,6 +133,11 @@ static int dispatch_procfs_write(struct file *file,
 		unsigned long count, void *data);
 static char *next_cmd(char **cmds);
 
+/* Device model */
+static struct platform_device *tpacpi_pdev;
+static struct class_device *tpacpi_hwmon;
+static struct platform_driver tpacpi_pdriver;
+
 /* Module */
 static int experimental;
 static u32 dbg_level;
-- 
1.5.1

