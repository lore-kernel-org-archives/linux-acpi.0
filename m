From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/37] ACPI: SBS: Add sysfs alarm
Date: Wed, 10 Oct 2007 01:06:39 -0400
Message-ID: <1191992804-14965-33-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:19103 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751406AbXJJFHK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:07:10 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <8bd955320661cfd03ab8d5574d96aa684acd38f6.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |   36 ++++++++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index aae65e8..90fd09c 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -386,8 +386,6 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	return result;
 }
 
-#ifdef CONFIG_ACPI_PROCFS
-
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
 	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
@@ -424,8 +422,6 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	return ret;
 }
 
-#endif
-
 static int acpi_ac_get_present(struct acpi_sbs *sbs)
 {
 	int result;
@@ -438,6 +434,36 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 	return result;
 }
 
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
 /* --------------------------------------------------------------------------
                               FS Interface (/proc/acpi)
    -------------------------------------------------------------------------- */
@@ -782,6 +808,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 	}
 	battery->bat.get_property = acpi_sbs_battery_get_property;
 	result = power_supply_register(&sbs->device->dev, &battery->bat);
+	device_create_file(battery->bat.dev, &alarm_attr);
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       battery->name, sbs->battery->present ? "present" : "absent");
@@ -791,6 +818,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	if (sbs->battery[id].bat.dev)
+		device_remove_file(sbs->battery[id].bat.dev, &alarm_attr);
 		power_supply_unregister(&sbs->battery[id].bat);
 #ifdef CONFIG_ACPI_PROCFS
 	if (sbs->battery[id].proc_entry) {
-- 
1.5.3.4.206.g58ba4
