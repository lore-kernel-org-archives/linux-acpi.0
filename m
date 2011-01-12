From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/48] ACPI / PM: Drop acpi_power_nocheck
Date: Wed, 12 Jan 2011 05:19:37 -0500
Message-ID: <53eac700b0df1fef8c957b9eedfd7f48120425e3.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49239 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab1ALSAY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:24 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:23 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Since acpi_bus_set_power() should not use __acpi_bus_get_power() to
update the device's device->power.state field before changing its
power state (this may cause device->power.state to be inconsistent
with the device power resources' reference counters), remove this
call from it.  In consequence, the acpi_power_nocheck variable is not
necessary any more, so it can be dropped along with the DMI table
used for setting that variable for HP Pavilion 05.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |   39 ---------------------------------------
 drivers/acpi/internal.h |    1 -
 drivers/acpi/power.c    |    3 ---
 3 files changed, 0 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 0baa5f9..7ced61f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -52,22 +52,6 @@ EXPORT_SYMBOL(acpi_root_dir);
 
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 
-static int set_power_nocheck(const struct dmi_system_id *id)
-{
-	printk(KERN_NOTICE PREFIX "%s detected - "
-		"disable power check in power transition\n", id->ident);
-	acpi_power_nocheck = 1;
-	return 0;
-}
-static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
-	{
-	set_power_nocheck, "HP Pavilion 05", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-	DMI_MATCH(DMI_SYS_VENDOR, "HP Pavilion 05"),
-	DMI_MATCH(DMI_PRODUCT_VERSION, "2001211RE101GLEND") }, NULL},
-	{},
-};
-
 
 #ifdef CONFIG_X86
 static int set_copy_dsdt(const struct dmi_system_id *id)
@@ -333,23 +317,6 @@ int acpi_bus_set_power(acpi_handle handle, int state)
 		return -ENODEV;
 	}
 
-	/*
-	 * Get device's current power state
-	 */
-	if (!acpi_power_nocheck) {
-		/*
-		 * Maybe the incorrect power state is returned on the bogus
-		 * bios, which is different with the real power state.
-		 * For example: the bios returns D0 state and the real power
-		 * state is D3. OS expects to set the device to D0 state. In
-		 * such case if OS uses the power state returned by the BIOS,
-		 * the device can't be transisted to the correct power state.
-		 * So if the acpi_power_nocheck is set, it is unnecessary to
-		 * get the power state by calling acpi_bus_get_power.
-		 */
-		__acpi_bus_get_power(device, &device->power.state);
-	}
-
 	return __acpi_bus_set_power(device, state);
 }
 EXPORT_SYMBOL(acpi_bus_set_power);
@@ -1072,12 +1039,6 @@ static int __init acpi_init(void)
 	if (acpi_disabled)
 		return result;
 
-	/*
-	 * If the laptop falls into the DMI check table, the power state check
-	 * will be disabled in the course of device power transition.
-	 */
-	dmi_check_system(power_nocheck_dmi_table);
-
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 7493e6c..8df5d70 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -45,7 +45,6 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
-extern int acpi_power_nocheck;
 
 int acpi_wakeup_device_init(void);
 void acpi_early_processor_set_pdc(void);
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 0cb4eab..0003f10 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -56,9 +56,6 @@ ACPI_MODULE_NAME("power");
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
-int acpi_power_nocheck;
-module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
-
 static int acpi_power_add(struct acpi_device *device);
 static int acpi_power_remove(struct acpi_device *device, int type);
 static int acpi_power_resume(struct acpi_device *device);
-- 
1.7.4.rc1.7.g2cf08

