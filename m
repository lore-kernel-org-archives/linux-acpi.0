From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 06/14] ACPI: thinkpad-acpi: claim tpacpi as an official short handle (v1.1)
Date: Sat, 26 Apr 2008 01:02:22 -0300
Message-ID: <1209182550-32725-7-git-send-email-hmh@hmh.eng.br>
References: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55738 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950AbYDZECg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Apr 2008 00:02:36 -0400
In-Reply-To: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Unfortunately, a lot of stuff in the kernel has size limitations, so
"thinkpad-acpi" ends up eating up too much real estate.  We were using
"tpacpi" in symbols already, but this shorthand was not visible to
userland.

Document that the driver will use tpacpi as a short hand where necessary,
and use it to name the kernel thread for NVRAM polling (now named
"ktpacpi_nvramd").

Also, register a module alias with the shorthand.  One can refer to the
module using the shorthand name.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    5 +++++
 drivers/misc/thinkpad_acpi.c            |    8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index a77da28..a41bc89 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -18,6 +18,11 @@ This driver used to be named ibm-acpi until kernel 2.6.21 and release
 moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
 2.6.22, and release 0.14.
 
+The driver is named "thinkpad-acpi".  In some places, like module
+names, "thinkpad_acpi" is used because of userspace issues.
+
+"tpacpi" is used as a shorthand where "thinkpad-acpi" would be too
+long due to length limitations on some Linux kernel versions.
 
 Status
 ------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 5e25abc..2b73dfa 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -133,8 +133,11 @@ enum {
 #define TPACPI_PROC_DIR "ibm"
 #define TPACPI_ACPI_EVENT_PREFIX "ibm"
 #define TPACPI_DRVR_NAME TPACPI_FILE
+#define TPACPI_DRVR_SHORTNAME "tpacpi"
 #define TPACPI_HWMON_DRVR_NAME TPACPI_NAME "_hwmon"
 
+#define TPACPI_NVRAM_KTHREAD_NAME "ktpacpi_nvramd"
+
 #define TPACPI_MAX_ACPI_ARGS 3
 
 /* Debugging */
@@ -1523,8 +1526,7 @@ static void hotkey_poll_setup(int may_warn)
 	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
-							 NULL,
-							 TPACPI_FILE "d");
+					NULL, TPACPI_NVRAM_KTHREAD_NAME);
 			if (IS_ERR(tpacpi_hotkey_task)) {
 				tpacpi_hotkey_task = NULL;
 				printk(TPACPI_ERR
@@ -6316,6 +6318,8 @@ static int __init thinkpad_acpi_module_init(void)
 /* Please remove this in year 2009 */
 MODULE_ALIAS("ibm_acpi");
 
+MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
+
 /*
  * DMI matching for module autoloading
  *
-- 
1.5.4.4

