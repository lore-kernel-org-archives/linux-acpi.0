From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/60] ACPI / PM: Fix problems with acpi_pm_device_sleep_state()
Date: Mon, 25 Oct 2010 02:20:29 -0400
Message-ID: <761afb869f649ea23e2dea7bfe9b550d3a1b7631.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab0JYHLU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:20 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:13 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

There is a number of problems with acpi_pm_device_sleep_state() now.
First, if _S0W is not defined, it prevents devices from being put
into D3 by PCI runtime PM, which shouldn't happen.  Second, it
shouldn't use adev->wakeup.state.enabled, because if it's set, it
only means that either the device is permanently enabled to wake up
the system, or that it has been enabled to do that through
/proc/acpi/wakeup.  Finally, it should be compiled if CONFIG_PM_SLEEP
is not set, so that PCI runtime PM works correctly in that case.
Fix these problems.

Reported-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c    |   16 ++++++++++------
 include/acpi/acpi_bus.h |   12 ++++++++----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4754ff6..e807f41 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -27,6 +27,8 @@
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
 	union acpi_object in_arg = { ACPI_TYPE_INTEGER };
@@ -79,8 +81,6 @@ static int acpi_sleep_prepare(u32 acpi_state)
 }
 
 #ifdef CONFIG_ACPI_SLEEP
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
-
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
  * and to restore them during the subsequent resume.  Windows does that also for
@@ -562,7 +562,7 @@ int acpi_suspend(u32 acpi_state)
 	return -EINVAL;
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_OPS
 /**
  *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
  *		in the system sleep state given by %acpi_target_sleep_state
@@ -624,7 +624,7 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) && adev->wakeup.state.enabled &&
+	    (device_may_wakeup(dev) &&
 	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
 		acpi_status status;
 
@@ -632,7 +632,9 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 		status = acpi_evaluate_integer(handle, acpi_method, NULL,
 						&d_max);
 		if (ACPI_FAILURE(status)) {
-			d_max = d_min;
+			if (acpi_target_sleep_state != ACPI_STATE_S0 ||
+			    status != AE_NOT_FOUND)
+				d_max = d_min;
 		} else if (d_max < d_min) {
 			/* Warn the user of the broken DSDT */
 			printk(KERN_WARNING "ACPI: Wrong value from %s\n",
@@ -646,7 +648,9 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 		*d_min_p = d_min;
 	return d_max;
 }
+#endif /* CONFIG_PM_OPS */
 
+#ifdef CONFIG_PM_SLEEP
 /**
  *	acpi_pm_device_sleep_wake - enable or disable the system wake-up
  *                                  capability of given device
@@ -677,7 +681,7 @@ int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 
 	return error;
 }
-#endif
+#endif  /* CONFIG_PM_SLEEP */
 
 static void acpi_power_off_prepare(void)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4de84ce..8ef68a1 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -389,21 +389,25 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_OPS
 int acpi_pm_device_sleep_state(struct device *, int *);
-int acpi_pm_device_sleep_wake(struct device *, bool);
-#else /* !CONFIG_PM_SLEEP */
+#else
 static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
 {
 	if (p)
 		*p = ACPI_STATE_D0;
 	return ACPI_STATE_D3;
 }
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+int acpi_pm_device_sleep_wake(struct device *, bool);
+#else
 static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 {
 	return -ENODEV;
 }
-#endif /* !CONFIG_PM_SLEEP */
+#endif
 
 #endif				/* CONFIG_ACPI */
 
-- 
1.7.3.2.90.gd4c43

