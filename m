From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/37] ACPI: thinkpad-acpi: keep track of module state
Date: Wed, 10 Oct 2007 01:06:20 -0400
Message-ID: <1191992804-14965-14-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:57218 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178AbXJJFG4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:56 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <8fef502e5a14df05f1e755edc9175e01c9814080.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Keep track of module state (init, running, exit).  This makes it trivially
easy to avoid running any interrupt handlers, threads, or any other async
activity before we are ready, or when we want to go away.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 0ced9d6..2155139 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -117,6 +117,12 @@ IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
 
 #define __unused __attribute__ ((unused))
 
+static enum {
+	TPACPI_LIFE_INIT = 0,
+	TPACPI_LIFE_RUNNING,
+	TPACPI_LIFE_EXITING,
+} tpacpi_lifecycle;
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -342,6 +348,9 @@ static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ibm_struct *ibm = data;
 
+	if (tpacpi_lifecycle != TPACPI_LIFE_RUNNING)
+		return;
+
 	if (!ibm || !ibm->acpi || !ibm->acpi->notify)
 		return;
 
@@ -3899,6 +3908,9 @@ static void fan_watchdog_fire(struct work_struct *ignored)
 {
 	int rc;
 
+	if (tpacpi_lifecycle != TPACPI_LIFE_RUNNING)
+		return;
+
 	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
 	rc = fan_set_enable();
 	if (rc < 0) {
@@ -3919,7 +3931,8 @@ static void fan_watchdog_reset(void)
 	if (fan_watchdog_active)
 		cancel_delayed_work(&fan_watchdog_task);
 
-	if (fan_watchdog_maxinterval > 0) {
+	if (fan_watchdog_maxinterval > 0 &&
+	    tpacpi_lifecycle != TPACPI_LIFE_EXITING) {
 		fan_watchdog_active = 1;
 		if (!schedule_delayed_work(&fan_watchdog_task,
 				msecs_to_jiffies(fan_watchdog_maxinterval
@@ -4685,6 +4698,8 @@ static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
 
+	tpacpi_lifecycle = TPACPI_LIFE_INIT;
+
 	/* Parameter checking */
 	if (hotkey_report_mode > 2)
 		return -EINVAL;
@@ -4781,6 +4796,7 @@ static int __init thinkpad_acpi_module_init(void)
 		tp_features.input_device_registered = 1;
 	}
 
+	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
 	return 0;
 }
 
@@ -4788,6 +4804,8 @@ static void thinkpad_acpi_module_exit(void)
 {
 	struct ibm_struct *ibm, *itmp;
 
+	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
+
 	list_for_each_entry_safe_reverse(ibm, itmp,
 					 &tpacpi_all_drivers,
 					 all_drivers) {
-- 
1.5.3.4.206.g58ba4
