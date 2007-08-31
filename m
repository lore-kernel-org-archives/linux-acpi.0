From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 8/9] ACPI: Battery: add sysfs alarm
Date: Sat, 01 Sep 2007 00:11:36 +0400
Message-ID: <20070831201136.27033.40358.stgit@z61m>
References: <20070831201051.27033.74238.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47918 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753364AbXHaULv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2007 16:11:51 -0400
In-Reply-To: <20070831201051.27033.74238.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index a29923d..8da312b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -696,6 +696,37 @@ static void acpi_battery_remove_fs(struct acpi_device *device)
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
@@ -744,6 +775,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	battery->bat.get_property = acpi_battery_get_property;
 	result = power_supply_register(&battery->device->dev, &battery->bat);
+	result = device_create_file(battery->bat.dev, &alarm_attr);
 #endif
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
@@ -781,8 +813,10 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
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

