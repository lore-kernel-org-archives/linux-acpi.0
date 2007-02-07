From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/140] ACPI: use more understandable bus_id for ACPI devices
Date: Wed,  7 Feb 2007 13:50:33 -0500
Message-ID: <11708743993414-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:13961 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422733AbXBGSxV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:21 -0500
In-Reply-To: <1170874398386-git-send-email-lenb@kernel.org>
Message-Id: <bb0958544f3c7c016b2a3025ab3694363e403aa1.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Some of the ACPI devices use the internal fake hids
which are exposed to userspace as devces' bus_id after sysfs conversion.
To make it more friendly, we convert them to more understandable strings.

For those devices w/o PNPids, we use "device:instance_no" as the bus_id
instead of "PNPIDNON:instance_no".

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c         |    6 +++---
 include/acpi/acpi_bus.h     |    2 +-
 include/acpi/acpi_drivers.h |   16 ++++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 30a39ba..4139e65 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -26,7 +26,7 @@ DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
 struct acpi_device_bus_id{
-	char bus_id[9];
+	char bus_id[15];
 	unsigned int instance_no;
 	struct list_head node;
 };
@@ -342,7 +342,7 @@ static int acpi_device_register(struct acpi_device *device,
 	 * If failed, create one and link it into acpi_bus_id_list
 	 */
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
-		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "PNPIDNON")) {
+		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "device")) {
 			acpi_device_bus_id->instance_no ++;
 			found = 1;
 			kfree(new_bus_id);
@@ -351,7 +351,7 @@ static int acpi_device_register(struct acpi_device *device,
 	}
 	if(!found) {
 		acpi_device_bus_id = new_bus_id;
-		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "PNPIDNON");
+		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "device");
 		acpi_device_bus_id->instance_no = 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a6b4037..e7df842 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -184,7 +184,7 @@ struct acpi_device_dir {
 
 typedef char acpi_bus_id[5];
 typedef unsigned long acpi_bus_address;
-typedef char acpi_hardware_id[9];
+typedef char acpi_hardware_id[15];
 typedef char acpi_unique_id[9];
 typedef char acpi_device_name[40];
 typedef char acpi_device_class[20];
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 2781e66..1b18c36 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -36,14 +36,14 @@
 
 /* _HID definitions */
 
-#define ACPI_POWER_HID			"ACPI_PWR"
-#define ACPI_PROCESSOR_HID		"ACPI_CPU"
-#define ACPI_SYSTEM_HID			"ACPI_SYS"
-#define ACPI_THERMAL_HID		"ACPI_THM"
-#define ACPI_BUTTON_HID_POWERF		"ACPI_FPB"
-#define ACPI_BUTTON_HID_SLEEPF		"ACPI_FSB"
-
-#define ACPI_VIDEO_HID			"ACPI_VID"
+#define ACPI_POWER_HID			"power_resource"
+#define ACPI_PROCESSOR_HID		"processor"
+#define ACPI_SYSTEM_HID			"acpi_system"
+#define ACPI_THERMAL_HID		"thermal"
+#define ACPI_BUTTON_HID_POWERF		"button_power"
+#define ACPI_BUTTON_HID_SLEEPF		"button_sleep"
+#define ACPI_VIDEO_HID			"video"
+#define ACPI_BAY_HID			"bay"
 /* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
-- 
1.5.0.rc3.39.gec804
