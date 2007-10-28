From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: battery: register power_supply subdevice only when
	battery is present
Date: Sun, 28 Oct 2007 12:50:09 +0300
Message-ID: <20071028095006.12422.99587.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:38554 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbXJ1Juu (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 05:50:50 -0400
In-Reply-To: 200710272054.31160.arvidjaar@mail.ru
References: 200710272054.31160.arvidjaar@mail.ru
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

From: Andrey Borzenkov <arvidjaar@mail.ru>

Make sure no power_supply object is present unless we actualy detect
presence of battery. This fixes ghost batteries detected by HAL

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |  130 ++++++++++++++++++++++++++++--------------------
 1 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6c06879..e3133bc 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -393,29 +393,81 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 	return acpi_battery_set_alarm(battery);
 }
 
+static ssize_t acpi_battery_alarm_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+	return sprintf(buf, "%d\n", battery->alarm * 1000);
+}
+
+static ssize_t acpi_battery_alarm_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	unsigned long x;
+	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+	if (sscanf(buf, "%ld\n", &x) == 1)
+		battery->alarm = x/1000;
+	if (acpi_battery_present(battery))
+		acpi_battery_set_alarm(battery);
+	return count;
+}
+
+static struct device_attribute alarm_attr = {
+	.attr = {.name = "alarm", .mode = 0644, .owner = THIS_MODULE},
+	.show = acpi_battery_alarm_show,
+	.store = acpi_battery_alarm_store,
+};
+
+static int sysfs_add_battery(struct acpi_battery *battery)
+{
+	int result;
+
+	battery->update_time = 0;
+	result = acpi_battery_get_info(battery);
+	acpi_battery_init_alarm(battery);
+	if (result)
+		return result;
+	if (battery->power_unit) {
+		battery->bat.properties = charge_battery_props;
+		battery->bat.num_properties =
+			ARRAY_SIZE(charge_battery_props);
+	} else {
+		battery->bat.properties = energy_battery_props;
+		battery->bat.num_properties =
+			ARRAY_SIZE(energy_battery_props);
+	}
+
+	battery->bat.name = acpi_device_bid(battery->device);
+	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
+	battery->bat.get_property = acpi_battery_get_property;
+
+	result = power_supply_register(&battery->device->dev, &battery->bat);
+	if (result)
+		return result;
+	return device_create_file(battery->bat.dev, &alarm_attr);
+}
+
+static void sysfs_remove_battery(struct acpi_battery *battery)
+{
+	if (!battery->bat.dev)
+		return;
+	device_remove_file(battery->bat.dev, &alarm_attr);
+	power_supply_unregister(&battery->bat);
+}
+
 static int acpi_battery_update(struct acpi_battery *battery)
 {
-	int saved_present = acpi_battery_present(battery);
 	int result = acpi_battery_get_status(battery);
-	if (result || !acpi_battery_present(battery))
+	if (result)
 		return result;
-	if (saved_present != acpi_battery_present(battery) ||
-	    !battery->update_time) {
-		battery->update_time = 0;
-		result = acpi_battery_get_info(battery);
-		if (result)
-			return result;
-		if (battery->power_unit) {
-			battery->bat.properties = charge_battery_props;
-			battery->bat.num_properties =
-				ARRAY_SIZE(charge_battery_props);
-		} else {
-			battery->bat.properties = energy_battery_props;
-			battery->bat.num_properties =
-				ARRAY_SIZE(energy_battery_props);
-		}
-		acpi_battery_init_alarm(battery);
+	if (!acpi_battery_present(battery)) {
+		sysfs_remove_battery(battery);
+		return 0;
 	}
+	if (!battery->bat.dev)
+		sysfs_add_battery(battery);
 	return acpi_battery_get_state(battery);
 }
 
@@ -696,33 +748,6 @@ static void acpi_battery_remove_fs(struct acpi_device *device)
 
 #endif
 
-static ssize_t acpi_battery_alarm_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
-	return sprintf(buf, "%d\n", battery->alarm * 1000);
-}
-
-static ssize_t acpi_battery_alarm_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
-{
-	unsigned long x;
-	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
-	if (sscanf(buf, "%ld\n", &x) == 1)
-		battery->alarm = x/1000;
-	if (acpi_battery_present(battery))
-		acpi_battery_set_alarm(battery);
-	return count;
-}
-
-static struct device_attribute alarm_attr = {
-	.attr = {.name = "alarm", .mode = 0644, .owner = THIS_MODULE},
-	.show = acpi_battery_alarm_show,
-	.store = acpi_battery_alarm_store,
-};
-
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -740,7 +765,9 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					device->dev.bus_id, event,
 					acpi_battery_present(battery));
-	kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
+	/* acpi_batter_update could remove power_supply object */
+	if (battery->bat.dev)
+		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -764,11 +791,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		goto end;
 #endif
-	battery->bat.name = acpi_device_bid(device);
-	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
-	battery->bat.get_property = acpi_battery_get_property;
-	result = power_supply_register(&battery->device->dev, &battery->bat);
-	result = device_create_file(battery->bat.dev, &alarm_attr);
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
 					     acpi_battery_notify, battery);
@@ -804,10 +826,7 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 #ifdef CONFIG_ACPI_PROCFS
 	acpi_battery_remove_fs(device);
 #endif
-	if (battery->bat.dev) {
-		device_remove_file(battery->bat.dev, &alarm_attr);
-		power_supply_unregister(&battery->bat);
-	}
+	sysfs_remove_battery(battery);
 	mutex_destroy(&battery->lock);
 	kfree(battery);
 	return 0;
@@ -821,6 +840,7 @@ static int acpi_battery_resume(struct acpi_device *device)
 		return -EINVAL;
 	battery = acpi_driver_data(device);
 	battery->update_time = 0;
+	acpi_battery_update(battery);
 	return 0;
 }
 

