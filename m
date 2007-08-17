From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: ACPI: SBS: Add sysfs alarm
Date: Fri, 17 Aug 2007 12:30:16 +0400
Message-ID: <46C55C98.7040805@gmail.com>
References: <46C4B6F1.9060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:27346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbXHQIaa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Aug 2007 04:30:30 -0400
Received: by ug-out-1314.google.com with SMTP id j3so315399ugf
        for <linux-acpi@vger.kernel.org>; Fri, 17 Aug 2007 01:30:28 -0700 (PDT)
In-Reply-To: <46C4B6F1.9060301@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/sbs.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index abf7b94..80a8e00 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -447,6 +447,40 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 	return result;
 }
 
+#ifdef ENABLE_POWER_SUPPLY
+
+static ssize_t acpi_battery_alarm_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+	acpi_battery_get_alarm(battery);
+	return sprintf(buf, "%d\n", battery->alarm_capacity *
+				acpi_battery_scale(battery) * 1000);
+}
+
+static ssize_t acpi_battery_alarm_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	unsigned long x;
+	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+	if (sscanf(buf, "%ld\n", &x) == 1)
+		battery->alarm_capacity = x /
+			(1000 * acpi_battery_scale(battery));
+	if (battery->present)
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
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc/acpi)
    -------------------------------------------------------------------------- */
@@ -792,6 +826,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 	}
 	battery->bat.get_property = acpi_sbs_battery_get_property;
 	result = power_supply_register(&sbs->device->dev, &battery->bat);
+	device_create_file(battery->bat.dev, &alarm_attr);
 #endif
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
@@ -803,6 +838,7 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 #ifdef ENABLE_POWER_SUPPLY
 	if (sbs->battery[id].bat.dev)
+		device_remove_file(sbs->battery[id].bat.dev, &alarm_attr);
 		power_supply_unregister(&sbs->battery[id].bat);
 #endif
 #ifdef CONFIG_ACPI_PROCFS
