From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/32] ACPI: Battery: add sysfs alarm
Date: Fri, 21 Sep 2007 23:46:29 -0400
Message-ID: <1190432817158-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
 <11904328111749-git-send-email-lenb@kernel.org>
 <11904328122495-git-send-email-lenb@kernel.org>
 <1190432813700-git-send-email-lenb@kernel.org>
 <11904328141573-git-send-email-lenb@kernel.org>
 <11904328153830-git-send-email-lenb@kernel.org>
 <11904328151023-git-send-email-lenb@kernel.org>
 <1190432816575-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:40564 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757315AbXIVDrA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:47:00 -0400
In-Reply-To: <1190432816575-git-send-email-lenb@kernel.org>
Message-Id: <0b5466f638ab34c816c862802833ea2e465ee58a.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikivskiy@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b77180a..4864694 100644
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
-- 
1.5.3.1.27.g57543
