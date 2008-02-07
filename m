From: Len Brown <lenb@kernel.org>
Subject: [PATCH 059/112] ACPI: attach thermal zone info
Date: Thu,  7 Feb 2008 04:34:21 -0500
Message-ID: <207339398ecb0835331c748612898dad2a09fdec.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756096AbYBGJgN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:13 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Intel menlow driver needs to get the pointer of themal_zone_device
structure of an ACPI thermal zone.
Attach this to each ACPI thermal zone device object.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |   25 +++++++++++++++++++++++++
 drivers/acpi/thermal.c  |   11 +++++++++++
 include/acpi/acpi_bus.h |    2 ++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1b4cf98..8df325d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -122,6 +122,31 @@ int acpi_bus_get_status(struct acpi_device *device)
 
 EXPORT_SYMBOL(acpi_bus_get_status);
 
+void acpi_bus_private_data_handler(acpi_handle handle,
+				   u32 function, void *context)
+{
+	return;
+}
+EXPORT_SYMBOL(acpi_bus_private_data_handler);
+
+int acpi_bus_get_private_data(acpi_handle handle, void **data)
+{
+	acpi_status status = AE_OK;
+
+	if (!*data)
+		return -EINVAL;
+
+	status = acpi_get_data(handle, acpi_bus_private_data_handler, data);
+	if (ACPI_FAILURE(status) || !*data) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No context for object [%p]\n",
+				handle));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_bus_get_private_data);
+
 /* --------------------------------------------------------------------------
                                  Power Management
    -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d317da5..7400363 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1101,6 +1101,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
 	int trips = 0;
 	int result;
+	acpi_status status;
 	int i;
 
 	if (tz->trips.critical.flags.valid)
@@ -1129,6 +1130,15 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (result)
 		return result;
 
+	status = acpi_attach_data(tz->device->handle,
+				  acpi_bus_private_data_handler,
+				  tz->thermal_zone);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error attaching device data\n"));
+		return -ENODEV;
+	}
+
 	tz->tz_enabled = 1;
 
 	printk(KERN_INFO PREFIX "%s is registered as thermal_zone%d\n",
@@ -1142,6 +1152,7 @@ static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
+	acpi_detach_data(tz->device->handle, acpi_bus_private_data_handler);
 }
 
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index fb7171b..504af20 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -321,6 +321,8 @@ struct acpi_bus_event {
 
 extern struct kobject *acpi_kobj;
 extern int acpi_bus_generate_netlink_event(const char*, const char*, u8, int);
+void acpi_bus_private_data_handler(acpi_handle, u32, void *);
+int acpi_bus_get_private_data(acpi_handle, void **);
 /*
  * External Functions
  */
-- 
1.5.4.23.gef5b9

