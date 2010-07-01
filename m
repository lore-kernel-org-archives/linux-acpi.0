From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/5] ACPI / Sleep: Consolidate suspend and hibernation routines
Date: Fri, 2 Jul 2010 00:14:09 +0200
Message-ID: <201007020014.09639.rjw@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42770 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932577Ab0GAWQz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:16:55 -0400
In-Reply-To: <201007020010.13755.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some hibernation and suspend routines can be merged, which reduces
the complexity of code a bit.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |   42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
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
@@ -317,9 +324,9 @@ static struct platform_suspend_ops acpi_
 static int acpi_suspend_begin_old(suspend_state_t pm_state)
 {
 	int error = acpi_suspend_begin(pm_state);
-
 	if (!error)
 		error = __acpi_pm_prepare();
+
 	return error;
 }
 
@@ -330,7 +337,7 @@ static int acpi_suspend_begin_old(suspen
 static struct platform_suspend_ops acpi_suspend_ops_old = {
 	.valid = acpi_suspend_state_valid,
 	.begin = acpi_suspend_begin_old,
-	.prepare_late = acpi_pm_freeze,
+	.prepare_late = acpi_pm_pre_suspend,
 	.enter = acpi_suspend_enter,
 	.wake = acpi_suspend_finish,
 	.end = acpi_pm_end,
@@ -418,16 +425,6 @@ static int acpi_hibernation_begin(void)
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
@@ -475,7 +472,7 @@ static void acpi_pm_thaw(void)
 static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.begin = acpi_hibernation_begin,
 	.end = acpi_pm_end,
-	.pre_snapshot = acpi_hibernation_pre_snapshot,
+	.pre_snapshot = acpi_pm_prepare,
 	.finish = acpi_pm_finish,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
@@ -511,13 +508,6 @@ static int acpi_hibernation_begin_old(vo
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
@@ -525,7 +515,7 @@ static int acpi_hibernation_pre_snapshot
 static struct platform_hibernation_ops acpi_hibernation_ops_old = {
 	.begin = acpi_hibernation_begin_old,
 	.end = acpi_pm_end,
-	.pre_snapshot = acpi_hibernation_pre_snapshot_old,
+	.pre_snapshot = acpi_pm_pre_suspend,
 	.prepare = acpi_pm_freeze,
 	.finish = acpi_pm_finish,
 	.enter = acpi_hibernation_enter,

