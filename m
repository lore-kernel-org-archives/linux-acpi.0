From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / LPSS: Power up LPSS devices during enumeration
Date: Tue, 18 Jun 2013 15:41:15 +0200
Message-ID: <4947718.ocNqGGkags@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41458 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725Ab3FRNb4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jun 2013 09:31:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 7cd8407 (ACPI / PM: Do not execute _PS0 for devices without
_PSC during initialization) introduced a regression on some systems
with Intel Low-Power Subsystem (LPSS) where some devices need to be
powered up during initialization, but their device objects in the
ACPI namespace have _PS0 and _PS3 only (without _PSC or power
resources).

To work around this problem, make the ACPI LPSS driver power up
devices it knows about by using a new helper function
acpi_device_fix_up_power() that does all of the necessary
sanity checks and calls acpi_dev_pm_explicit_set() to put the
device into D0.

Reported-and-tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c |   21 +++++++++++++++------
 drivers/acpi/device_pm.c |   20 ++++++++++++++++++++
 include/acpi/acpi_bus.h  |    1 +
 3 files changed, 36 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -280,15 +280,24 @@ static int acpi_lpss_create_device(struc
 	if (dev_desc->clk_required) {
 		ret = register_device_clock(adev, pdata);
 		if (ret) {
-			/*
-			 * Skip the device, but don't terminate the namespace
-			 * scan.
-			 */
-			kfree(pdata);
-			return 0;
+			/* Skip the device, but continue the namespace scan. */
+			ret = 0;
+			goto err_out;
 		}
 	}
 
+	/*
+	 * This works around a known issue in ACPI tables where LPSS devices
+	 * have _PS0 and _PS3 without _PSC (and no power resources), so
+	 * acpi_bus_init_power() will assume that the BIOS has put them into D0.
+	 */
+	ret = acpi_device_fix_up_power(adev);
+	if (ret) {
+		/* Skip the device, but continue the namespace scan. */
+		ret = 0;
+		goto err_out;
+	}
+
 	adev->driver_data = pdata;
 	ret = acpi_create_platform_device(adev, id);
 	if (ret > 0)
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -288,6 +288,26 @@ int acpi_bus_init_power(struct acpi_devi
 	return 0;
 }
 
+/**
+ * acpi_device_fix_up_power - Force device with missing _PSC into D0.
+ * @device: Device object whose power state is to be fixed up.
+ *
+ * Devices without power resources and _PSC, but having _PS0 and _PS3 defined,
+ * are assumed to be put into D0 by the BIOS.  However, in some cases that may
+ * not be the case and this function should be used then.
+ */
+int acpi_device_fix_up_power(struct acpi_device *device)
+{
+	int ret = 0;
+
+	if (!device->power.flags.power_resources
+	    && !device->power.flags.explicit_get
+	    && device->power.state == ACPI_STATE_D0)
+		ret = acpi_dev_pm_explicit_set(device, ACPI_STATE_D0);
+
+	return ret;
+}
+
 int acpi_bus_update_power(acpi_handle handle, int *state_p)
 {
 	struct acpi_device *device;
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -372,6 +372,7 @@ const char *acpi_power_state_string(int
 int acpi_device_get_power(struct acpi_device *device, int *state);
 int acpi_device_set_power(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
+int acpi_device_fix_up_power(struct acpi_device *device);
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
 

