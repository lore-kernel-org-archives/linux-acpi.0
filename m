From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 9/9] ACPI: SBS: Add sysfs alarm
Date: Sat, 01 Sep 2007 00:11:43 +0400
Message-ID: <20070831201143.27033.4019.stgit@z61m>
References: <20070831201051.27033.74238.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47920 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753465AbXHaULv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2007 16:11:51 -0400
In-Reply-To: <20070831201051.27033.74238.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/sbs.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 21a65f9..3f249df 100644
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

