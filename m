From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Load device driver according to the status of acpi
	device
Date: Fri, 07 Dec 2007 11:18:35 +0800
Message-ID: <1196997515.4045.5.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8854 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbXLGDYa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Dec 2007 22:24:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Load device driver according to the status of acpi device
>From : Zhao Yakui <yakui.zhao@intel.com>

According to ACPI spec when the status of some device is not present 
but functional, the device is valid and the children of this device 
should be enumerated. It means that the device should be added to 
linux acpi device tree.
But the device driver for this device should not be loaded. 

http://bugzilla.kernel.org/show_bug.cgi?id=3358

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/bus.c         |   11 +++++------
 drivers/acpi/scan.c        |   20 ++++++++++++++++++--
 drivers/pnp/pnpacpi/core.c |    6 +++++-
 3 files changed, 28 insertions(+), 9 deletions(-)

Index: linux-2.6.24-rc4/drivers/acpi/bus.c
===================================================================
--- linux-2.6.24-rc4.orig/drivers/acpi/bus.c
+++ linux-2.6.24-rc4/drivers/acpi/bus.c
@@ -97,11 +97,11 @@ int acpi_bus_get_status(struct acpi_devi
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
@@ -109,9 +109,8 @@ int acpi_bus_get_status(struct acpi_devi
 
 	if (device->status.functional && !device->status.present) {
 		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
-		       "functional but not present; setting present\n",
+		       "functional but not present.\n",
 		       device->pnp.bus_id, (u32) STRUCT_TO_INT(device->status));
-		device->status.present = 1;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
Index: linux-2.6.24-rc4/drivers/acpi/scan.c
===================================================================
--- linux-2.6.24-rc4.orig/drivers/acpi/scan.c
+++ linux-2.6.24-rc4/drivers/acpi/scan.c
@@ -257,6 +257,11 @@ int acpi_match_device_ids(struct acpi_de
 			  const struct acpi_device_id *ids)
 {
 	const struct acpi_device_id *id;
+	/*
+	 * If the device is not present, the device driver is not loaded.
+	 */
+	if (!device->status.present)
+		return -ENODEV;
 
 	if (device->flags.hardware_id) {
 		for (id = ids; id->id[0]; id++) {
@@ -1131,7 +1136,13 @@ acpi_add_single_object(struct acpi_devic
 	case ACPI_BUS_TYPE_PROCESSOR:
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result) || (!device->status.present &&
+					!device->status.functional)) {
+		/*
+		 * When the device is neither present nor functional, the
+		 * device should not be added to Linux ACPI device tree.
+		 */
+
 			result = -ENOENT;
 			goto end;
 		}
@@ -1306,7 +1317,12 @@ static int acpi_bus_scan(struct acpi_dev
 		 * TBD: Need notifications and other detection mechanisms
 		 *      in place before we can fully implement this.
 		 */
-		if (child->status.present) {
+		/*
+		 * When the device is not present but functional, it is also
+		 * necessary to scan the children of this device.
+		 */
+		if ((child->status.present) || (!child->status.present &&
+						child->status.functional)) {
 			status = acpi_get_next_object(ACPI_TYPE_ANY, chandle,
 						      NULL, NULL);
 			if (ACPI_SUCCESS(status)) {
Index: linux-2.6.24-rc4/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-2.6.24-rc4.orig/drivers/pnp/pnpacpi/core.c
+++ linux-2.6.24-rc4/drivers/pnp/pnpacpi/core.c
@@ -166,9 +166,13 @@ static int __init pnpacpi_add_device(str
 	struct pnp_id *dev_id;
 	struct pnp_dev *dev;
 
+	/*
+	 * If a PnPacpi device is not present , the device
+	 * driver should not be loaded.
+	 */
 	status = acpi_get_handle(device->handle, "_CRS", &temp);
 	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
-	    is_exclusive_device(device))
+	    is_exclusive_device(device) || !device->status.present)
 		return 0;
 
 	dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
