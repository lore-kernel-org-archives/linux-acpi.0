From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/37] ACPI: AC: Add sysfs interface
Date: Wed, 10 Oct 2007 01:06:40 -0400
Message-ID: <1191992804-14965-34-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:57266 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbXJJFHN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:07:13 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <d5b4a3d0efa36de31b86d5677dad6c36cb8735d7.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Refer to Documentation/power_supply_class.txt for interface description.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    2 +-
 drivers/acpi/ac.c    |   33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ba6a61f..a858bc5 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -88,7 +88,7 @@ config ACPI_PROC_EVENT
 
 config ACPI_AC
 	tristate "AC Adapter"
-	depends on X86
+	depends on X86 && POWER_SUPPLY
 	default y
 	help
 	  This driver adds support for the AC Adapter object, which indicates
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 26d7070..e03de37 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/power_supply.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -72,16 +73,37 @@ static struct acpi_driver acpi_ac_driver = {
 };
 
 struct acpi_ac {
+	struct power_supply charger;
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
 
 /* --------------------------------------------------------------------------
                                AC Adapter Management
@@ -208,6 +230,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event,
 						  (u32) ac->state);
+		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -244,7 +267,12 @@ static int acpi_ac_add(struct acpi_device *device)
 	result = acpi_ac_add_fs(device);
 	if (result)
 		goto end;
-
+	ac->charger.name = acpi_device_bid(device);
+	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
+	ac->charger.properties = ac_props;
+	ac->charger.num_properties = ARRAY_SIZE(ac_props);
+	ac->charger.get_property = get_ac_property;
+	power_supply_register(&ac->device->dev, &ac->charger);
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY, acpi_ac_notify,
 					     ac);
@@ -279,7 +307,8 @@ static int acpi_ac_remove(struct acpi_device *device, int type)
 
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY, acpi_ac_notify);
-
+	if (ac->charger.dev)
+		power_supply_unregister(&ac->charger);
 	acpi_ac_remove_fs(device);
 
 	kfree(ac);
-- 
1.5.3.4.206.g58ba4
