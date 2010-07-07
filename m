From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI battery: don't invoke power_supply_changed twice when
 battery is hot-added
Date: Wed, 07 Jul 2010 09:11:57 +0800
Message-ID: <1278465117.4537.7520.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35901 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506Ab0GGBKY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Jul 2010 21:10:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>


When battery is hot-added, we should not invoke power_supply_changed
in acpi_battery_notify, because it has been invoked in acpi_battery_update,
and battery->bat.changed_work is queued in keventd already.
https://bugzilla.kernel.org/show_bug.cgi?id=16244

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Alexey Starikovskiy <astarikovskiy@sude.de>
---
 drivers/acpi/battery.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6-clean/drivers/acpi/battery.c
===================================================================
--- linux-2.6-clean.orig/drivers/acpi/battery.c
+++ linux-2.6-clean/drivers/acpi/battery.c
@@ -868,9 +868,15 @@ static void acpi_battery_remove_fs(struc
 static void acpi_battery_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_battery *battery = acpi_driver_data(device);
+#ifdef CONFIG_ACPI_SYSFS_POWER
+	struct device *old;
+#endif
 
 	if (!battery)
 		return;
+#ifdef CONFIG_ACPI_SYSFS_POWER
+	old = battery->bat.dev;
+#endif
 	acpi_battery_update(battery);
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
@@ -879,7 +885,7 @@ static void acpi_battery_notify(struct a
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_battery_update could remove power_supply object */
-	if (battery->bat.dev)
+	if (old && battery->bat.dev)
 		power_supply_changed(&battery->bat);
 #endif
 }


