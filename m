From: Len Brown <lenb@kernel.org>
Subject: [PATCH 161/171] ACPI: thinkpad-acpi: claim tpacpi as an official short handle
Date: Tue, 29 Apr 2008 04:44:26 -0400
Message-ID: <32cfa7598852f915962d1ff505828b05cff485bc.1209457073.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757452AbYD2Ips (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:48 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    5 +++++
 drivers/misc/thinkpad_acpi.c            |    8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index bbc8275..0f403ff 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -18,6 +18,11 @@ This driver used to be named ibm-acpi until kernel 2.6.21 and release
 moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
 2.6.22, and release 0.14.
 
+The driver is named "thinkpad-acpi".  In some places, like module
+names, "thinkpad_acpi" is used because of userspace issues.
+
+"tpacpi" is used as a shorthand where "thinkpad-acpi" would be too
+long due to lenght limitations on some Linux kernel versions.
 
 Status
 ------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 1a26423..f23acc8 100644
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
@@ -1522,8 +1525,7 @@ static void hotkey_poll_setup(int may_warn)
 	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
-							 NULL,
-							 TPACPI_FILE "d");
+					NULL, TPACPI_NVRAM_KTHREAD_NAME);
 			if (IS_ERR(tpacpi_hotkey_task)) {
 				tpacpi_hotkey_task = NULL;
 				printk(TPACPI_ERR
@@ -6315,6 +6317,8 @@ static int __init thinkpad_acpi_module_init(void)
 /* Please remove this in year 2009 */
 MODULE_ALIAS("ibm_acpi");
 
+MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
+
 /*
  * DMI matching for module autoloading
  *
-- 
1.5.5.1.99.gf0ec4

