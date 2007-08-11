From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: [PATCH] ACPI: AC: add sysfs support
Date: Sat, 11 Aug 2007 23:57:08 +0400
Message-ID: <46BE1494.2070305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030203030003090804070809"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20394 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbXHKT5R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Aug 2007 15:57:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so509497ugf
        for <linux-acpi@vger.kernel.org>; Sat, 11 Aug 2007 12:57:16 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030203030003090804070809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Len,

This patch adds sysfs support to ACPI AC.


Regards,
Alex.

--------------030203030003090804070809
Content-Type: text/x-patch;
 name="add_sysfs_to_ac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_sysfs_to_ac.patch"

ACPI: AC: Add sysfs interface

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ac.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index d8b3509..d13b961 100644
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
@@ -205,6 +237,9 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		acpi_ac_get_state(ac);
 		acpi_bus_generate_event(device, event, (u32) ac->state);
+#ifdef ENABLE_POWER_SUPPLY
+		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
+#endif
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -241,7 +276,14 @@ static int acpi_ac_add(struct acpi_device *device)
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
@@ -276,7 +318,10 @@ static int acpi_ac_remove(struct acpi_device *device, int type)
 
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY, acpi_ac_notify);
-
+#ifdef ENABLE_POWER_SUPPLY
+	if (ac->charger.dev)
+		power_supply_unregister(&ac->charger);
+#endif
 	acpi_ac_remove_fs(device);
 
 	kfree(ac);

--------------030203030003090804070809--
