From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/9] ACPI: thinkpad-acpi: keep track of module state
Date: Sun, 23 Sep 2007 11:24:12 -0300
Message-ID: <11905574571845-git-send-email-hmh@hmh.eng.br>
References: <1190557457539-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41488 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754128AbXIWOY0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 10:24:26 -0400
In-Reply-To: <1190557457539-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Keep track of module state (init, running, exit).  This makes it trivially
easy to avoid running any interrupt handlers, threads, or any other async
activity before we are ready, or when we want to go away.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
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
1.5.3.1

