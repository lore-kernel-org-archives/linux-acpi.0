From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: SBS: Fix retval warning
Date: Sun, 18 Nov 2007 00:32:31 +0300
Message-ID: <20071117213231.9287.31719.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:46676 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942AbXKQVc2 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 17 Nov 2007 16:32:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

drivers/acpi/sbs.c: In function acpi_battery_add:
drivers/acpi/sbs.c:811: warning: ignoring return value of device_create_file,
declared with attribute warn_unused_result

Additional cleanups:
* use struct acpi_battery in acpi_battery_remove() to clean up function
calls, just like acpi_battery_add() already does.

* put braces around unregister call, as it depends on dev being not NULL.

* remove unneeded braces

Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/sbs.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 90fd09c..73c1ba3 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -113,6 +113,7 @@ struct acpi_battery {
 	u16 spec;
 	u8 id;
 	u8 present:1;
+	u8 have_sysfs_alarm:1;
 };
 
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
@@ -808,7 +809,13 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 	}
 	battery->bat.get_property = acpi_sbs_battery_get_property;
 	result = power_supply_register(&sbs->device->dev, &battery->bat);
-	device_create_file(battery->bat.dev, &alarm_attr);
+	if (result)
+		goto end;
+	result = device_create_file(battery->bat.dev, &alarm_attr);
+	if (result)
+		goto end;
+	battery->have_sysfs_alarm = 1;
+      end:
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       battery->name, sbs->battery->present ? "present" : "absent");
@@ -817,14 +824,16 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 
 static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
-	if (sbs->battery[id].bat.dev)
-		device_remove_file(sbs->battery[id].bat.dev, &alarm_attr);
-		power_supply_unregister(&sbs->battery[id].bat);
-#ifdef CONFIG_ACPI_PROCFS
-	if (sbs->battery[id].proc_entry) {
-		acpi_sbs_remove_fs(&(sbs->battery[id].proc_entry),
-				   acpi_battery_dir);
+	struct acpi_battery *battery = &sbs->battery[id];
+
+	if (battery->bat.dev) {
+		if (battery->have_sysfs_alarm)
+			device_remove_file(battery->bat.dev, &alarm_attr);
+		power_supply_unregister(&battery->bat);
 	}
+#ifdef CONFIG_ACPI_PROCFS
+	if (battery->proc_entry)
+		acpi_sbs_remove_fs(&battery->proc_entry, acpi_battery_dir);
 #endif
 }
 

