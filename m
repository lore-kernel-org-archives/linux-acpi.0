From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: battery: register power_supply subdevice even when
	battery not present
Date: Mon, 05 Apr 2010 20:23:46 +0400
Message-ID: <20100405162346.2760.94455.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:34334 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755495Ab0DEQXr (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 5 Apr 2010 12:23:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Keeping this device around lets userspace know that we have a battery
bay, even if there is nothing in it at the moment.  This is what every
other battery driver does, so ACPI should do it as well.

For example, this means gnome-power-manager will now allow configuring
behaviour for "on battery power" if the battery bay was empty on
startup. (Thanks to Maxim Levitsky for pointing this out).

There is no reason to preserve the old behaviour.  We now correctly
provide the "present" attribute, which will return "0" when the battery
is removed.  HAL was already trying to check this attribute when
the old behaviour was implemented.  This should not break any version
of HAL.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |   36 ++++++++++++++++--------------------
 1 files changed, 16 insertions(+), 20 deletions(-)


diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index db78b6e..5b9fd78 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -546,8 +546,6 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	if (!battery->bat.dev)
-		return;
 	device_remove_file(battery->bat.dev, &alarm_attr);
 	power_supply_unregister(&battery->bat);
 	battery->bat.dev = NULL;
@@ -568,9 +566,6 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	if (result)
 		return result;
 	if (!acpi_battery_present(battery)) {
-#ifdef CONFIG_ACPI_SYSFS_POWER
-		sysfs_remove_battery(battery);
-#endif
 		battery->update_time = 0;
 		return 0;
 	}
@@ -582,10 +577,6 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		acpi_battery_quirks(battery);
 		acpi_battery_init_alarm(battery);
 	}
-#ifdef CONFIG_ACPI_SYSFS_POWER
-	if (!battery->bat.dev)
-		sysfs_add_battery(battery);
-#endif
 	return acpi_battery_get_state(battery);
 }
 
@@ -877,9 +868,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
-	/* acpi_battery_update could remove power_supply object */
-	if (battery->bat.dev)
-		power_supply_changed(&battery->bat);
+	power_supply_changed(&battery->bat);
 #endif
 }
 
@@ -904,17 +893,24 @@ static int acpi_battery_add(struct acpi_device *device)
 	acpi_battery_update(battery);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
+	if (result)
+		goto fail;
 #endif
-	if (!result) {
-		printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
-			ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
-			device->status.battery_present ? "present" : "absent");
-	} else {
+#ifdef CONFIG_ACPI_SYSFS_POWER
+	result = sysfs_add_battery(battery);
+	if (result)
+		goto fail;
+#endif
+	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
+		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
+		device->status.battery_present ? "present" : "absent");
+	return 0;
+
+fail:
 #ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_battery_remove_fs(device);
+	acpi_battery_remove_fs(device);
 #endif
-		kfree(battery);
-	}
+	kfree(battery);
 	return result;
 }
 

