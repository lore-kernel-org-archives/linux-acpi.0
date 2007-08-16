From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: ACPI: Battery: Add alarm sysfs support
Date: Fri, 17 Aug 2007 00:43:29 +0400
Message-ID: <46C4B6F1.9060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:51655 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbXHPUne (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Aug 2007 16:43:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so291904ugf
        for <linux-acpi@vger.kernel.org>; Thu, 16 Aug 2007 13:43:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2be9f45..3968d3b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -697,6 +697,37 @@ static void acpi_battery_remove_fs(struct acpi_device *device)
 }
 
 #endif
+
+#ifdef ENABLE_POWER_SUPPLY
+
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
+#endif
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -740,6 +771,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	battery->bat.get_property = acpi_battery_get_property;
 	result = power_supply_register(&battery->device->dev, &battery->bat);
+	result = device_create_file(battery->bat.dev, &alarm_attr);
 #endif
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
@@ -777,8 +809,10 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 	acpi_battery_remove_fs(device);
 #endif
 #ifdef ENABLE_POWER_SUPPLY
-	if (battery->bat.dev)
+	if (battery->bat.dev) {
+		device_remove_file(battery->bat.dev, &alarm_attr);
 		power_supply_unregister(&battery->bat);
+	}
 #endif
 	mutex_destroy(&battery->lock);
 	kfree(battery);
