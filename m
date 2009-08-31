From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 15/19] ACPI: identify device tree root by null parent
	pointer, not ACPI_BUS_TYPE
Date: Mon, 31 Aug 2009 16:33:22 -0600
Message-ID: <20090831223322.11814.63755.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:43800 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbZHaWdP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:33:15 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We can identify the root of the ACPI device tree by the fact that it
has no parent.  This is simpler than passing around ACPI_BUS_TYPE_SYSTEM
and will help remove special treatment of the device tree root.

Currently, we add the root by hand with ACPI_BUS_TYPE_SYSTEM.  If we
traverse the tree treating the root as just another device and use
acpi_get_type(), the root shows up as ACPI_TYPE_DEVICE.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c     |   20 +++++++++++++-------
 include/acpi/acpi_bus.h |    1 -
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3e4228f..5565b34 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -22,6 +22,8 @@ extern struct acpi_device *acpi_root;
 #define ACPI_BUS_HID			"LNXSYBUS"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
+#define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
+
 static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
 DEFINE_MUTEX(acpi_device_lock);
@@ -950,10 +952,12 @@ static void acpi_device_get_busid(struct acpi_device *device)
 	 * The device's Bus ID is simply the object name.
 	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
 	 */
-	switch (device->device_type) {
-	case ACPI_BUS_TYPE_SYSTEM:
+	if (ACPI_IS_ROOT_DEVICE(device)) {
 		strcpy(device->pnp.bus_id, "ACPI");
-		break;
+		return;
+	}
+
+	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		strcpy(device->pnp.bus_id, "PWRF");
 		break;
@@ -1088,6 +1092,11 @@ static void acpi_device_set_id(struct acpi_device *device)
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
+		if (ACPI_IS_ROOT_DEVICE(device)) {
+			hid = ACPI_SYSTEM_HID;
+			break;
+		}
+
 		status = acpi_get_object_info(device->handle, &info);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
@@ -1124,9 +1133,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 	case ACPI_BUS_TYPE_PROCESSOR:
 		hid = ACPI_PROCESSOR_OBJECT_HID;
 		break;
-	case ACPI_BUS_TYPE_SYSTEM:
-		hid = ACPI_SYSTEM_HID;
-		break;
 	case ACPI_BUS_TYPE_THERMAL:
 		hid = ACPI_THERMAL_HID;
 		break;
@@ -1645,7 +1651,7 @@ int __init acpi_scan_init(void)
 	 * Create the root device in the bus's device tree
 	 */
 	result = acpi_add_single_object(&acpi_root, ACPI_ROOT_OBJECT,
-					ACPI_BUS_TYPE_SYSTEM, &ops);
+					ACPI_BUS_TYPE_DEVICE, &ops);
 	if (result)
 		goto Done;
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c652405..0ce840b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -70,7 +70,6 @@ enum acpi_bus_device_type {
 	ACPI_BUS_TYPE_POWER,
 	ACPI_BUS_TYPE_PROCESSOR,
 	ACPI_BUS_TYPE_THERMAL,
-	ACPI_BUS_TYPE_SYSTEM,
 	ACPI_BUS_TYPE_POWER_BUTTON,
 	ACPI_BUS_TYPE_SLEEP_BUTTON,
 	ACPI_BUS_DEVICE_TYPE_COUNT

