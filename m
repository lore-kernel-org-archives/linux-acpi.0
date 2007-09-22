From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/32] ACPI: SBS: Add sysfs alarm
Date: Fri, 21 Sep 2007 23:46:21 -0400
Message-ID: <1190432811241-git-send-email-lenb@kernel.org>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:2443 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756927AbXIVDqw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:52 -0400
In-Reply-To: <11904328102889-git-send-email-lenb@kernel.org>
Message-Id: <f127e3766686c2d525d930fb2a707cc90df9e2f1.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.5.3.1.27.g57543
