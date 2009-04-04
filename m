From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 06/12] thinkpad-acpi: add new debug helpers and warn of deprecated atts
Date: Sat,  4 Apr 2009 01:25:47 -0300
Message-ID: <1238819153-16004-7-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43063 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329AbZDDE0B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:01 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add a debug helper that discloses the TGID of the userspace task
attempting to access the driver.  This is highly useful when dealing
with bug reports, since often the user has no idea that some userspace
application is accessing thinkpad-acpi...

Also add a helper to log warnings about sysfs attributes that are
deprecated.

Use the new helpers to issue deprecation warnings for bluetooth_enable
and wwan_enabled, that have been deprecated for a while, now.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +
 drivers/platform/x86/thinkpad_acpi.c    |   40 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index f6e6bc6..e8f52fb 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1484,6 +1484,8 @@ will enable all debugging output classes.  It takes a bitmask, so
 to enable more than one output class, just add their values.
 
 	Debug bitmask		Description
+	0x8000			Disclose PID of userspace programs
+				accessing some functions of the driver
 	0x0001			Initialization and probing
 	0x0002			Removal
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c93324a..badf471 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -54,6 +54,7 @@
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/sched.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/delay.h>
@@ -185,6 +186,7 @@ enum {
 
 /* Debugging printk groups */
 #define TPACPI_DBG_ALL		0xffff
+#define TPACPI_DBG_DISCLOSETASK	0x8000
 #define TPACPI_DBG_INIT		0x0001
 #define TPACPI_DBG_EXIT		0x0002
 
@@ -335,6 +337,21 @@ static const char *str_supported(int is_supported);
 	do { } while (0)
 #endif
 
+static void tpacpi_log_usertask(const char * const what)
+{
+	printk(TPACPI_DEBUG "%s: access by process with PID %d\n",
+		what, task_tgid_vnr(current));
+}
+
+#define tpacpi_disclose_usertask(what, format, arg...) \
+	do { \
+		if (unlikely( \
+		    (dbg_level & TPACPI_DBG_DISCLOSETASK) && \
+		    (tpacpi_lifecycle == TPACPI_LIFE_RUNNING))) { \
+			printk(TPACPI_DEBUG "%s: PID %d: " format, \
+				what, task_tgid_vnr(current), ## arg); \
+		} \
+	} while (0)
 
 /****************************************************************************
  ****************************************************************************
@@ -1030,6 +1047,21 @@ static int __init tpacpi_new_rfkill(const unsigned int id,
 	return 0;
 }
 
+static void printk_deprecated_attribute(const char * const what,
+					const char * const details)
+{
+	tpacpi_log_usertask("deprecated sysfs attribute");
+	printk(TPACPI_WARN "WARNING: sysfs attribute %s is deprecated and "
+		"will be removed. %s\n",
+		what, details);
+}
+
+static void printk_deprecated_rfkill_attribute(const char * const what)
+{
+	printk_deprecated_attribute(what,
+			"Please switch to generic rfkill before year 2010");
+}
+
 /*************************************************************************
  * thinkpad-acpi driver attributes
  */
@@ -3070,6 +3102,8 @@ static ssize_t bluetooth_enable_show(struct device *dev,
 {
 	int status;
 
+	printk_deprecated_rfkill_attribute("bluetooth_enable");
+
 	status = bluetooth_get_radiosw();
 	if (status < 0)
 		return status;
@@ -3085,6 +3119,8 @@ static ssize_t bluetooth_enable_store(struct device *dev,
 	unsigned long t;
 	int res;
 
+	printk_deprecated_rfkill_attribute("bluetooth_enable");
+
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
 
@@ -3347,6 +3383,8 @@ static ssize_t wan_enable_show(struct device *dev,
 {
 	int status;
 
+	printk_deprecated_rfkill_attribute("wwan_enable");
+
 	status = wan_get_radiosw();
 	if (status < 0)
 		return status;
@@ -3362,6 +3400,8 @@ static ssize_t wan_enable_store(struct device *dev,
 	unsigned long t;
 	int res;
 
+	printk_deprecated_rfkill_attribute("wwan_enable");
+
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
 
-- 
1.6.2.1

