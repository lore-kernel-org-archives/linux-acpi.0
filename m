From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [RESEND] [PATCH 3/3] ACPI: battery: register power_supply subdevice
 even when battery not present
Date: Tue, 30 Jun 2009 15:37:17 +0100
Message-ID: <4A4A231D.6090202@tuffmail.co.uk>
References: <4A4A219C.2020802@tuffmail.co.uk> <4A4A2299.8060401@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:44521 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405AbZF3OhV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2009 10:37:21 -0400
Received: by ewy6 with SMTP id 6so231017ewy.37
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2009 07:37:24 -0700 (PDT)
In-Reply-To: <4A4A2299.8060401@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

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
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/battery.c |   36 ++++++++++++++++--------------------
 1 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 7d31a23..f424033 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -487,8 +487,6 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	if (!battery->bat.dev)
-		return;
 	device_remove_file(battery->bat.dev, &alarm_attr);
 	power_supply_unregister(&battery->bat);
 	battery->bat.dev = NULL;
@@ -502,9 +500,6 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	if (result)
 		return result;
 	if (!acpi_battery_present(battery)) {
-#ifdef CONFIG_ACPI_SYSFS_POWER
-		sysfs_remove_battery(battery);
-#endif
 		battery->update_time = 0;
 		return 0;
 	}
@@ -515,10 +510,6 @@ static int acpi_battery_update(struct acpi_battery *battery)
 			return result;
 		acpi_battery_init_alarm(battery);
 	}
-#ifdef CONFIG_ACPI_SYSFS_POWER
-	if (!battery->bat.dev)
-		sysfs_add_battery(battery);
-#endif
 	return acpi_battery_get_state(battery);
 }
 
@@ -809,9 +800,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
-	/* acpi_batter_update could remove power_supply object */
-	if (battery->bat.dev)
-		power_supply_changed(&battery->bat);
+	power_supply_changed(&battery->bat);
 #endif
 }
 
@@ -832,17 +821,24 @@ static int acpi_battery_add(struct acpi_device *device)
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
 
-- 
1.6.3.2



