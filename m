From: Len Brown <lenb@kernel.org>
Subject: [PATCH 074/122] ACPI : Load device driver according to the status of
 acpi device
Date: Thu, 23 Oct 2008 02:38:48 -0400
Message-ID: <39a0ad871000d2a016a4fa113a6e53d22aabf25d.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbYJWGoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:23 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:17 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

According to ACPI spec when the status of some device is not present
but functional, the device is valid and the children of this device
should be enumerated. It means that the device should be added to
linux acpi device tree. But the device driver for this device should not
be loaded.
    The detailed info can be found in the section 6.3.7 of ACPI 3.0b spec.
    _STA may return bit 0 clear (not present) with bit 3 set (device is
functional). This case is used to indicate a valid device for which no
device driver should be loaded (for example, a bridge device.).
Children of this device may be present and valid. OS should continue
enumeration below a device whose _STA returns this bit combination

http://bugzilla.kernel.org/show_bug.cgi?id=3358

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c         |   16 ++++++++--------
 drivers/acpi/scan.c        |   35 +++++++++++++++++++++++++----------
 drivers/pnp/pnpacpi/core.c |    6 +++++-
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 945cd2f..e9b116d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -112,21 +112,21 @@ int acpi_bus_get_status(struct acpi_device *device)
 	}
 
 	/*
-	 * Otherwise we assume the status of our parent (unless we don't
-	 * have one, in which case status is implied).
+	 * According to ACPI spec some device can be present and functional
+	 * even if the parent is not present but functional.
+	 * In such conditions the child device should not inherit the status
+	 * from the parent.
 	 */
-	else if (device->parent)
-		device->status = device->parent->status;
 	else
 		STRUCT_TO_INT(device->status) =
 		    ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
 		    ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
 
 	if (device->status.functional && !device->status.present) {
-		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
-		       "functional but not present; setting present\n",
-		       device->pnp.bus_id, (u32) STRUCT_TO_INT(device->status));
-		device->status.present = 1;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]: "
+		       "functional but not present;\n",
+			device->pnp.bus_id,
+			(u32) STRUCT_TO_INT(device->status)));
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ad06798..89c112e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -276,6 +276,13 @@ int acpi_match_device_ids(struct acpi_device *device,
 {
 	const struct acpi_device_id *id;
 
+	/*
+	 * If the device is not present, it is unnecessary to load device
+	 * driver for it.
+	 */
+	if (!device->status.present)
+		return -ENODEV;
+
 	if (device->flags.hardware_id) {
 		for (id = ids; id->id[0]; id++) {
 			if (!strcmp((char*)id->id, device->pnp.hardware_id))
@@ -1222,15 +1229,18 @@ acpi_add_single_object(struct acpi_device **child,
 			result = -ENODEV;
 			goto end;
 		}
-		if (!device->status.present) {
-			/* Bay and dock should be handled even if absent */
-			if (!ACPI_SUCCESS(
-			     acpi_is_child_device(device, acpi_bay_match)) &&
-			    !ACPI_SUCCESS(
-			     acpi_is_child_device(device, acpi_dock_match))) {
-					result = -ENODEV;
-					goto end;
-			}
+		/*
+		 * When the device is neither present nor functional, the
+		 * device should not be added to Linux ACPI device tree.
+		 * When the status of the device is not present but functinal,
+		 * it should be added to Linux ACPI tree. For example : bay
+		 * device , dock device.
+		 * In such conditions it is unncessary to check whether it is
+		 * bay device or dock device.
+		 */
+		if (!device->status.present && !device->status.functional) {
+			result = -ENODEV;
+			goto end;
 		}
 		break;
 	default:
@@ -1411,7 +1421,12 @@ static int acpi_bus_scan(struct acpi_device *start, struct acpi_bus_ops *ops)
 		 * TBD: Need notifications and other detection mechanisms
 		 *      in place before we can fully implement this.
 		 */
-		if (child->status.present) {
+		 /*
+		 * When the device is not present but functional, it is also
+		 * necessary to scan the children of this device.
+		 */
+		if (child->status.present || (!child->status.present &&
+					child->status.functional)) {
 			status = acpi_get_next_object(ACPI_TYPE_ANY, chandle,
 						      NULL, NULL);
 			if (ACPI_SUCCESS(status)) {
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index c1b9ea3..98b9df7 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -148,9 +148,13 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	acpi_status status;
 	struct pnp_dev *dev;
 
+	/*
+	 * If a PnPacpi device is not present , the device
+	 * driver should not be loaded.
+	 */
 	status = acpi_get_handle(device->handle, "_CRS", &temp);
 	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
-	    is_exclusive_device(device))
+	    is_exclusive_device(device) || (!device->status.present))
 		return 0;
 
 	dev = pnp_alloc_dev(&pnpacpi_protocol, num, acpi_device_hid(device));
-- 
1.5.5.1

