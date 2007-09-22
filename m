From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/32] ACPI: AC: Add sysfs interface
Date: Fri, 21 Sep 2007 23:46:10 -0400
Message-ID: <11904328011699-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18967 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754344AbXIVDqm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:42 -0400
In-Reply-To: <11904328012791-git-send-email-lenb@kernel.org>
Message-Id: <481ad1a30bb2f3fba90f004055ad266f27e19199.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikivskiy@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Refer to Documentation/power_supply_class.txt for interface description.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 26d7070..a08ecbb 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -29,6 +29,12 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+
+#if defined(CONFIG_POWER_SUPPLY) || defined(CONFIG_POWER_SUPPLY_MODULE)
+#define ENABLE_POWER_SUPPLY
+#include <linux/power_supply.h>
+#endif
+
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -72,16 +78,42 @@ static struct acpi_driver acpi_ac_driver = {
 };
 
 struct acpi_ac {
+#ifdef ENABLE_POWER_SUPPLY
+	struct power_supply charger;
+#endif
 	struct acpi_device * device;
 	unsigned long state;
 };
 
+#define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
+
 static const struct file_operations acpi_ac_fops = {
 	.open = acpi_ac_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#ifdef ENABLE_POWER_SUPPLY
+static int get_ac_property(struct power_supply *psy,
+			   enum power_supply_property psp,
+			   union power_supply_propval *val)
+{
+	struct acpi_ac *ac = to_acpi_ac(psy);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ac->state;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+#endif
 
 /* --------------------------------------------------------------------------
                                AC Adapter Management
@@ -208,6 +240,9 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event,
 						  (u32) ac->state);
+#ifdef ENABLE_POWER_SUPPLY
+		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
+#endif
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -244,7 +279,14 @@ static int acpi_ac_add(struct acpi_device *device)
 	result = acpi_ac_add_fs(device);
 	if (result)
 		goto end;
-
+#ifdef ENABLE_POWER_SUPPLY
+	ac->charger.name = acpi_device_bid(device);
+	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
+	ac->charger.properties = ac_props;
+	ac->charger.num_properties = ARRAY_SIZE(ac_props);
+	ac->charger.get_property = get_ac_property;
+	power_supply_register(&ac->device->dev, &ac->charger);
+#endif
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY, acpi_ac_notify,
 					     ac);
@@ -279,7 +321,10 @@ static int acpi_ac_remove(struct acpi_device *device, int type)
 
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY, acpi_ac_notify);
-
+#ifdef ENABLE_POWER_SUPPLY
+	if (ac->charger.dev)
+		power_supply_unregister(&ac->charger);
+#endif
 	acpi_ac_remove_fs(device);
 
 	kfree(ac);
-- 
1.5.3.1.27.g57543
