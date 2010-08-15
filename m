From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/20] ACPI / Wakeup: Simplify enabling of wakeup devices
Date: Sun, 15 Aug 2010 01:23:07 -0400
Message-ID: <78f5f023167813130d2cf657d1b9eadc32f0e992.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:39439 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab0HOFXe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:34 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L76009EPHN5WFT2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:32 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

To simplify the enabling of wakeup devices during system suspend and
hibernation, merge acpi_enable_wakeup_device_prep() with
acpi_disable_wakeup_device() and remove unnecessary (and no longer
valid) comments from the latter.  Rename acpi_enable_wakeup_device()
to acpi_enable_wakeup_devices() and acpi_disable_wakeup_device()
to acpi_disable_wakeup_devices(), because these functions usually
operate on multiple device objects.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c  |    5 ++---
 drivers/acpi/sleep.h  |    5 ++---
 drivers/acpi/wakeup.c |   48 ++++++++++--------------------------------------
 3 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8704ca78..93441c9 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -73,8 +73,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
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
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 25b8bd1..d882180 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
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
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 388747a..dc6d1d9 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
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
 
@@ -68,6 +40,9 @@ void acpi_enable_wakeup_device(u8 sleep_state)
 		    || sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
+		if (dev->wakeup.state.enabled)
+			acpi_enable_wakeup_device_power(dev, sleep_state);
+
 		/* The wake-up power should have been enabled already. */
 		acpi_enable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
 				ACPI_GPE_TYPE_WAKE);
@@ -75,13 +50,10 @@ void acpi_enable_wakeup_device(u8 sleep_state)
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
 
-- 
1.7.2.1.95.g3d045

