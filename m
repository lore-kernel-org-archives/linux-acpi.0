From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 4/5] ACPI: thinkpad-acpi: cleanup after
	rename
Date: Thu, 29 Mar 2007 01:58:43 -0300
Message-ID: <11751443251874-git-send-email-hmh@hmh.eng.br>
References: <11751443243976-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11751443243976-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Cleanup documentation, driver strings and other misc stuff, now that the
driver is named "thinkpad-acpi".

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
 
                Borislav Deianov <borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
 	     Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
  *  Copyright (C) 2004-2005 Borislav Deianov <borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
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
  *  Copyright (C) 2004-2005 Borislav Deianov <borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
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
1.5.0.3


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
