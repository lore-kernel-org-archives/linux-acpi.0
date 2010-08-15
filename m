From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/20] ACPI / Sleep: Consolidate suspend and hibernation
 routines
Date: Sun, 15 Aug 2010 01:23:08 -0400
Message-ID: <c5f7a1bb65bca03253c189e946b3ca79669f08af.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:39439 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab0HOFXd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:33 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600MNVHN5SEJ1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:32 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Some hibernation and suspend routines can be merged, which reduces
the complexity of code a bit.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |   42 ++++++++++++++++--------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 93441c9..61c5bd0 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -105,6 +105,16 @@ static int acpi_pm_freeze(void)
 }
 
 /**
+ * acpi_pre_suspend - Enable wakeup devices, "freeze" EC and save NVS.
+ */
+static int acpi_pm_pre_suspend(void)
+{
+	acpi_pm_freeze();
+	suspend_nvs_save();
+	return 0;
+}
+
+/**
  *	__acpi_pm_prepare - Prepare the platform to enter the target state.
  *
  *	If necessary, set the firmware waking vector and do arch-specific
@@ -113,11 +123,9 @@ static int acpi_pm_freeze(void)
 static int __acpi_pm_prepare(void)
 {
 	int error = acpi_sleep_prepare(acpi_target_sleep_state);
-
-	suspend_nvs_save();
-
 	if (error)
 		acpi_target_sleep_state = ACPI_STATE_S0;
+
 	return error;
 }
 
@@ -128,9 +136,8 @@ static int __acpi_pm_prepare(void)
 static int acpi_pm_prepare(void)
 {
 	int error = __acpi_pm_prepare();
-
 	if (!error)
-		acpi_pm_freeze();
+		acpi_pm_pre_suspend();
 
 	return error;
 }
@@ -322,9 +329,9 @@ static struct platform_suspend_ops acpi_suspend_ops = {
 static int acpi_suspend_begin_old(suspend_state_t pm_state)
 {
 	int error = acpi_suspend_begin(pm_state);
-
 	if (!error)
 		error = __acpi_pm_prepare();
+
 	return error;
 }
 
@@ -335,7 +342,7 @@ static int acpi_suspend_begin_old(suspend_state_t pm_state)
 static struct platform_suspend_ops acpi_suspend_ops_old = {
 	.valid = acpi_suspend_state_valid,
 	.begin = acpi_suspend_begin_old,
-	.prepare_late = acpi_pm_freeze,
+	.prepare_late = acpi_pm_pre_suspend,
 	.enter = acpi_suspend_enter,
 	.wake = acpi_suspend_finish,
 	.end = acpi_pm_end,
@@ -423,16 +430,6 @@ static int acpi_hibernation_begin(void)
 	return error;
 }
 
-static int acpi_hibernation_pre_snapshot(void)
-{
-	int error = acpi_pm_prepare();
-
-	if (!error)
-		suspend_nvs_save();
-
-	return error;
-}
-
 static int acpi_hibernation_enter(void)
 {
 	acpi_status status = AE_OK;
@@ -480,7 +477,7 @@ static void acpi_pm_thaw(void)
 static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.begin = acpi_hibernation_begin,
 	.end = acpi_pm_end,
-	.pre_snapshot = acpi_hibernation_pre_snapshot,
+	.pre_snapshot = acpi_pm_prepare,
 	.finish = acpi_pm_finish,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
@@ -516,13 +513,6 @@ static int acpi_hibernation_begin_old(void)
 	return error;
 }
 
-static int acpi_hibernation_pre_snapshot_old(void)
-{
-	acpi_pm_freeze();
-	suspend_nvs_save();
-	return 0;
-}
-
 /*
  * The following callbacks are used if the pre-ACPI 2.0 suspend ordering has
  * been requested.
@@ -530,7 +520,7 @@ static int acpi_hibernation_pre_snapshot_old(void)
 static struct platform_hibernation_ops acpi_hibernation_ops_old = {
 	.begin = acpi_hibernation_begin_old,
 	.end = acpi_pm_end,
-	.pre_snapshot = acpi_hibernation_pre_snapshot_old,
+	.pre_snapshot = acpi_pm_pre_suspend,
 	.prepare = acpi_pm_freeze,
 	.finish = acpi_pm_finish,
 	.enter = acpi_hibernation_enter,
-- 
1.7.2.1.95.g3d045

