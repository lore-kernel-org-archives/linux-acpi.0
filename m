From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 3/5] ACPI / Wakeup: Simplify enabling of wakeup devices
Date: Wed, 7 Jul 2010 01:17:16 +0200
Message-ID: <201007070117.16557.rjw@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl> <201007020013.27000.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57145 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab0GFXSy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Jul 2010 19:18:54 -0400
In-Reply-To: <201007020013.27000.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, July 02, 2010, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> To simplify the enabling of wakeup devices during system suspend and
> hibernation, merge acpi_enable_wakeup_device_prep() with
> acpi_disable_wakeup_device() and remove unnecessary (and no longer
> valid) comments from the latter.  Rename acpi_enable_wakeup_device()
> to acpi_enable_wakeup_devices() and acpi_disable_wakeup_device()
> to acpi_disable_wakeup_devices(), because these functions usually
> operate on multiple device objects.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Below is a version without the last hunk in wakeup.c (that didin't apply and
was cosmetic-only).

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / Wakeup: Simplify enabling of wakeup devices

To simplify the enabling of wakeup devices during system suspend and
hibernation, merge acpi_enable_wakeup_device_prep() with
acpi_disable_wakeup_device() and remove unnecessary (and no longer
valid) comments from the latter.  Rename acpi_enable_wakeup_device()
to acpi_enable_wakeup_devices() and acpi_disable_wakeup_device()
to acpi_disable_wakeup_devices(), because these functions usually
operate on multiple device objects.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c  |    5 ++---
 drivers/acpi/sleep.h  |    5 ++---
 drivers/acpi/wakeup.c |   50 +++++++++++---------------------------------------
 3 files changed, 15 insertions(+), 45 deletions(-)

Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -21,46 +21,18 @@
 ACPI_MODULE_NAME("wakeup_devices")
 
 /**
- * acpi_enable_wakeup_device_prep - Prepare wake-up devices.
+ * acpi_enable_wakeup_devices - Enable wake-up device GPEs.
  * @sleep_state: ACPI system sleep state.
  *
- * Enable all wake-up devices' power, unless the requested system sleep state is
- * too deep.
+ * Enable wakeup device power of devices with the state.enable flag set and set
+ * the wakeup enable mask bits in the GPE registers that correspond to wakeup
+ * devices.
  */
-void acpi_enable_wakeup_device_prep(u8 sleep_state)
+void acpi_enable_wakeup_devices(u8 sleep_state)
 {
 	struct list_head *node, *next;
 
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device *dev = container_of(node,
-						       struct acpi_device,
-						       wakeup_list);
-
-		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled
-		    || (sleep_state > (u32) dev->wakeup.sleep_state))
-			continue;
-
-		acpi_enable_wakeup_device_power(dev, sleep_state);
-	}
-}
-
-/**
- * acpi_enable_wakeup_device - Enable wake-up device GPEs.
- * @sleep_state: ACPI system sleep state.
- *
- * Enable all wake-up devices' GPEs, with the assumption that
- * acpi_disable_all_gpes() was executed before, so we don't need to disable any
- * GPEs here.
- */
-void acpi_enable_wakeup_device(u8 sleep_state)
-{
-	struct list_head *node, *next;
-
-	/* 
-	 * Caution: this routine must be invoked when interrupt is disabled 
-	 * Refer ACPI2.0: P212
-	 */
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
 
@@ -69,6 +41,9 @@ void acpi_enable_wakeup_device(u8 sleep_
 		    || sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
+		if (dev->wakeup.state.enabled)
+			acpi_enable_wakeup_device_power(dev, sleep_state);
+
 		/* The wake-up power should have been enabled already. */
 		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
 				ACPI_GPE_ENABLE);
@@ -76,13 +51,10 @@ void acpi_enable_wakeup_device(u8 sleep_
 }
 
 /**
- * acpi_disable_wakeup_device - Disable devices' wakeup capability.
+ * acpi_disable_wakeup_devices - Disable devices' wakeup capability.
  * @sleep_state: ACPI system sleep state.
- *
- * This function only affects devices with wakeup.state.enabled set, which means
- * that it reverses the changes made by acpi_enable_wakeup_device_prep().
  */
-void acpi_disable_wakeup_device(u8 sleep_state)
+void acpi_disable_wakeup_devices(u8 sleep_state)
 {
 	struct list_head *node, *next;
 
Index: linux-2.6/drivers/acpi/sleep.h
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.h
+++ linux-2.6/drivers/acpi/sleep.h
@@ -2,9 +2,8 @@
 extern u8 sleep_states[];
 extern int acpi_suspend(u32 state);
 
-extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
-extern void acpi_enable_wakeup_device(u8 sleep_state);
-extern void acpi_disable_wakeup_device(u8 sleep_state);
+extern void acpi_enable_wakeup_devices(u8 sleep_state);
+extern void acpi_disable_wakeup_devices(u8 sleep_state);
 
 extern struct list_head acpi_wakeup_device_list;
 extern struct mutex acpi_device_lock;
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -73,8 +73,7 @@ static int acpi_sleep_prepare(u32 acpi_s
 #endif
 	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
 		acpi_state);
-	acpi_enable_wakeup_device_prep(acpi_state);
-	acpi_enable_wakeup_device(acpi_state);
+	acpi_enable_wakeup_devices(acpi_state);
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
@@ -153,7 +152,7 @@ static void acpi_pm_finish(void)
 
 	printk(KERN_INFO PREFIX "Waking up from system sleep state S%d\n",
 		acpi_state);
-	acpi_disable_wakeup_device(acpi_state);
+	acpi_disable_wakeup_devices(acpi_state);
 	acpi_leave_sleep_state(acpi_state);
 
 	/* reset firmware waking vector */
