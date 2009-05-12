From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 3/3] ACPI: battery: register power_supply subdevice even when
 battery not present
Date: Tue, 12 May 2009 15:51:54 +0100
Message-ID: <4A098D0A.6090509@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:50621 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbZELOv6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2009 10:51:58 -0400
Received: by ey-out-2122.google.com with SMTP id 9so23626eyd.37
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2009 07:51:57 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

Keeping this device around lets userspace know that we have a battery
bay, even if there is nothing in it at the moment.  This is what every
other battery driver does, so ACPI should do it as well.

There is no reason to preserve the old behaviour.  We now correctly
provide the "present" attribute, which will return "0" when the battery
is removed.  HAL was already trying to check this attribute, so
it should be fine.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9208e97..9331f01 100644
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
 
@@ -810,9 +801,7 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
-	/* acpi_batter_update could remove power_supply object */
-	if (battery->bat.dev)
-		power_supply_changed(&battery->bat);
+	power_supply_changed(&battery->bat);
 #endif
 }
 
@@ -837,6 +826,11 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		goto end;
 #endif
+#ifdef CONFIG_ACPI_SYSFS_POWER
+	result = sysfs_add_battery(battery);
+	if (result)
+		goto end;
+#endif
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
 					     acpi_battery_notify, battery);


