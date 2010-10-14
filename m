From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH] ACPI / PM: Fix problems with acpi_pm_device_sleep_state()
Date: Thu, 14 Oct 2010 23:24:13 +0200
Message-ID: <201010142324.13460.rjw@sisk.pl>
References: <201010070048.20890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47053 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669Ab0JNVZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Oct 2010 17:25:24 -0400
In-Reply-To: <201010070048.20890.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>

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
---
 drivers/acpi/sleep.c    |   16 ++++++++++------
 include/acpi/acpi_bus.h |   12 ++++++++----
 2 files changed, 18 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -27,6 +27,8 @@
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
 	union acpi_object in_arg = { ACPI_TYPE_INTEGER };
@@ -79,8 +81,6 @@ static int acpi_sleep_prepare(u32 acpi_s
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
@@ -624,7 +624,7 @@ int acpi_pm_device_sleep_state(struct de
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) && adev->wakeup.state.enabled &&
+	    (device_may_wakeup(dev) &&
 	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
 		acpi_status status;
 
@@ -632,7 +632,9 @@ int acpi_pm_device_sleep_state(struct de
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
@@ -646,7 +648,9 @@ int acpi_pm_device_sleep_state(struct de
 		*d_min_p = d_min;
 	return d_max;
 }
+#endif /* CONFIG_PM_OPS */
 
+#ifdef CONFIG_PM_SLEEP
 /**
  *	acpi_pm_device_sleep_wake - enable or disable the system wake-up
  *                                  capability of given device
@@ -677,7 +681,7 @@ int acpi_pm_device_sleep_wake(struct dev
 
 	return error;
 }
-#endif
+#endif  /* CONFIG_PM_SLEEP */
 
 static void acpi_power_off_prepare(void)
 {
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -389,21 +389,25 @@ struct acpi_pci_root *acpi_pci_find_root
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
 
