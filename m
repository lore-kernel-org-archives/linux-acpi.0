From: Len Brown <len.brown@intel.com>
Subject: [PATCH 035/105] ACPI: thinkpad-acpi: cleanup after rename
Date: Sun, 29 Apr 2007 00:50:35 -0400
Message-ID: <11778223392178-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54971 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842AbXD2EwU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:20 -0400
In-Reply-To: <11778223382880-git-send-email-len.brown@intel.com>
Message-Id: <643f12dbb660e139fbaea268f3e3ce4d7d594b8f.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Cleanup documentation, driver strings and other misc stuff, now that the
driver is named "thinkpad-acpi".

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   46 ++++++++++++++++++++++----------------
 drivers/misc/thinkpad_acpi.c    |   18 +++++++++------
 drivers/misc/thinkpad_acpi.h    |   21 +++++++++--------
 3 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index f409f4b..af18d29 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -1,17 +1,22 @@
-		    IBM ThinkPad ACPI Extras Driver
+		     ThinkPad ACPI Extras Driver
 
-                            Version 0.13
-                           31 December 2006
+                            Version 0.14
+                          March 26th, 2007
 
                Borislav Deianov <borislav@users.sf.net>
 	     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
 		      http://ibm-acpi.sf.net/
 
 
-This is a Linux ACPI driver for the IBM ThinkPad laptops. It supports
-various features of these laptops which are accessible through the
-ACPI framework but not otherwise fully supported by the generic Linux
-ACPI drivers.
+This is a Linux driver for the IBM and Lenovo ThinkPad laptops. It
+supports various features of these laptops which are accessible
+through the ACPI and ACPI EC framework, but not otherwise fully
+supported by the generic Linux ACPI drivers.
+
+This driver used to be named ibm-acpi until kernel 2.6.21 and release
+0.13-20070314.  It used to be in the drivers/acpi tree, but it was
+moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
+2.6.22, and release 0.14.
 
 
 Status
@@ -43,6 +48,8 @@ Please include the following information in your report:
 
 	- ThinkPad model name
 	- a copy of your DSDT, from /proc/acpi/dsdt
+	- a copy of the output of dmidecode, with serial numbers
+	  and UUIDs masked off
 	- which driver features work and which don't
 	- the observed behavior of non-working features
 
@@ -53,8 +60,9 @@ Installation
 ------------
 
 If you are compiling this driver as included in the Linux kernel
-sources, simply enable the CONFIG_ACPI_IBM option (Power Management /
-ACPI / IBM ThinkPad Laptop Extras).
+sources, simply enable the CONFIG_THINKPAD_ACPI option, and optionally
+enable the CONFIG_THINKPAD_ACPI_BAY option if you want the
+thinkpad-specific bay functionality.
 
 Features
 --------
@@ -210,7 +218,7 @@ hot plugging of devices in the Linux ACPI framework. If the laptop was
 booted while not in the dock, the following message is shown in the
 logs:
 
-	Mar 17 01:42:34 aero kernel: ibm_acpi: dock device not present
+	Mar 17 01:42:34 aero kernel: thinkpad_acpi: dock device not present
 
 In this case, no dock-related events are generated but the dock and
 undock commands described below still work. They can be executed
@@ -270,7 +278,7 @@ This is due to the current lack of support for hot plugging of devices
 in the Linux ACPI framework. If the laptop was booted without the
 UltraBay, the following message is shown in the logs:
 
-	Mar 17 01:42:34 aero kernel: ibm_acpi: bay device not present
+	Mar 17 01:42:34 aero kernel: thinkpad_acpi: bay device not present
 
 In this case, no bay-related events are generated but the eject
 command described below still works. It can be executed manually or
@@ -637,12 +645,12 @@ range. The fan cannot be stopped or started with this command.
 
 The ThinkPad's ACPI DSDT code will reprogram the fan on its own when
 certain conditions are met.  It will override any fan programming done
-through ibm-acpi.
+through thinkpad-acpi.
 
-The ibm-acpi kernel driver can be programmed to revert the fan level
-to a safe setting if userspace does not issue one of the fan commands:
-"enable", "disable", "level" or "watchdog" within a configurable
-ammount of time.  To do this, use the "watchdog" command.
+The thinkpad-acpi kernel driver can be programmed to revert the fan
+level to a safe setting if userspace does not issue one of the fan
+commands: "enable", "disable", "level" or "watchdog" within a
+configurable ammount of time.  To do this, use the "watchdog" command.
 
 	echo 'watchdog <interval>' > /proc/acpi/ibm/fan
 
@@ -686,8 +694,8 @@ separating them with commas, for example:
 	echo enable,0xffff > /proc/acpi/ibm/hotkey
 	echo lcd_disable,crt_enable > /proc/acpi/ibm/video
 
-Commands can also be specified when loading the ibm_acpi module, for
-example:
+Commands can also be specified when loading the thinkpad-acpi module,
+for example:
 
-	modprobe ibm_acpi hotkey=enable,0xffff video=auto_disable
+	modprobe thinkpad_acpi hotkey=enable,0xffff video=auto_disable
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 90ffc46..ddaedf8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1,5 +1,5 @@
 /*
- *  ibm_acpi.c - IBM ThinkPad ACPI Extras
+ *  thinkpad_acpi.c - ThinkPad ACPI Extras
  *
  *
  *  Copyright (C) 2004-2005 Borislav Deianov <borislav@users.sf.net>
@@ -21,10 +21,12 @@
  *  02110-1301, USA.
  */
 
-#define IBM_VERSION "0.13"
+#define IBM_VERSION "0.14"
 
 /*
  *  Changelog:
+ *  2007-03-27  0.14	renamed to thinkpad_acpi and moved to
+ *  			drivers/misc.
  *
  *  2006-11-22	0.13	new maintainer
  *  			changelog now lives in git commit history, and will
@@ -318,7 +320,9 @@ static int __init setup_notify(struct ibm_struct *ibm)
 	}
 
 	acpi_driver_data(ibm->device) = ibm;
-	sprintf(acpi_device_class(ibm->device), "%s/%s", IBM_NAME, ibm->name);
+	sprintf(acpi_device_class(ibm->device), "%s/%s",
+		IBM_ACPI_EVENT_PREFIX,
+		ibm->name);
 
 	status = acpi_install_notify_handler(*ibm->handle, ibm->type,
 					     dispatch_notify, ibm);
@@ -458,7 +462,7 @@ static char *next_cmd(char **cmds)
  * ibm-acpi init subdriver
  */
 
-static int ibm_acpi_driver_init(void)
+static int thinkpad_acpi_driver_init(void)
 {
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
 	printk(IBM_INFO "%s\n", IBM_URL);
@@ -470,7 +474,7 @@ static int ibm_acpi_driver_init(void)
 	return 0;
 }
 
-static int ibm_acpi_driver_read(char *p)
+static int thinkpad_acpi_driver_read(char *p)
 {
 	int len = 0;
 
@@ -2440,8 +2444,8 @@ static struct proc_dir_entry *proc_dir = NULL;
 static struct ibm_struct ibms[] = {
 	{
 	 .name = "driver",
-	 .init = ibm_acpi_driver_init,
-	 .read = ibm_acpi_driver_read,
+	 .init = thinkpad_acpi_driver_init,
+	 .read = thinkpad_acpi_driver_read,
 	 },
 	{
 	 .name = "hotkey",
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index ee1b93a..015c02b 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -1,5 +1,5 @@
 /*
- *  ibm_acpi.h - IBM ThinkPad ACPI Extras
+ *  thinkpad_acpi.h - ThinkPad ACPI Extras
  *
  *
  *  Copyright (C) 2004-2005 Borislav Deianov <borislav@users.sf.net>
@@ -21,8 +21,8 @@
  *  02110-1301, USA.
  */
 
-#ifndef __IBM_ACPI_H__
-#define __IBM_ACPI_H__
+#ifndef __THINKPAD_ACPI_H__
+#define __THINKPAD_ACPI_H__
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -47,12 +47,13 @@
  * Main driver
  */
 
-#define IBM_NAME "ibm"
-#define IBM_DESC "IBM ThinkPad ACPI Extras"
-#define IBM_FILE "ibm_acpi"
+#define IBM_NAME "thinkpad"
+#define IBM_DESC "ThinkPad ACPI Extras"
+#define IBM_FILE "thinkpad_acpi"
 #define IBM_URL "http://ibm-acpi.sf.net/"
 
-#define IBM_DIR IBM_NAME
+#define IBM_DIR "ibm"
+#define IBM_ACPI_EVENT_PREFIX "ibm"
 
 #define IBM_LOG IBM_FILE ": "
 #define IBM_ERR	   KERN_ERR    IBM_LOG
@@ -99,8 +100,8 @@ static void ibm_handle_init(char *name,
 
 /* procfs support */
 static struct proc_dir_entry *proc_dir;
-static int ibm_acpi_driver_init(void);
-static int ibm_acpi_driver_read(char *p);
+static int thinkpad_acpi_driver_init(void);
+static int thinkpad_acpi_driver_read(char *p);
 
 /* procfs helpers */
 static int dispatch_read(char *page, char **start, off_t off, int count,
@@ -434,4 +435,4 @@ static int wan_read(char *p);
 static int wan_write(char *buf);
 
 
-#endif /* __IBM_ACPI_H */
+#endif /* __THINKPAD_ACPI_H */
-- 
1.5.2.rc0.34.gda94
