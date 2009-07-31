From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 15/19] ACPI: identify device tree root by null parent pointer,
	not ACPI_BUS_TYPE
Date: Fri, 31 Jul 2009 15:37:49 -0600
Message-ID: <20090731213749.29930.48586.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:2358 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbZGaViq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:38:46 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
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
 drivers/acpi/scan.c     |   18 +++++++++++-------
 include/acpi/acpi_bus.h |    1 -
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b97b2ad..c0736f6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -950,10 +950,12 @@ static void acpi_device_get_busid(struct acpi_device *device)
 	 * The device's Bus ID is simply the object name.
 	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
 	 */
-	switch (device->device_type) {
-	case ACPI_BUS_TYPE_SYSTEM:
+	if (!device->parent) {
 		strcpy(device->pnp.bus_id, "ACPI");
-		break;
+		return;
+	}
+
+	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		strcpy(device->pnp.bus_id, "PWRF");
 		break;
@@ -1031,6 +1033,11 @@ static void acpi_device_set_id(struct acpi_device *device)
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
+		if (!device->parent) {
+			hid = ACPI_SYSTEM_HID;
+			break;
+		}
+
 		status = acpi_get_object_info(device->handle, &buffer);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
@@ -1068,9 +1075,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 	case ACPI_BUS_TYPE_PROCESSOR:
 		hid = ACPI_PROCESSOR_OBJECT_HID;
 		break;
-	case ACPI_BUS_TYPE_SYSTEM:
-		hid = ACPI_SYSTEM_HID;
-		break;
 	case ACPI_BUS_TYPE_THERMAL:
 		hid = ACPI_THERMAL_HID;
 		break;
@@ -1599,7 +1603,7 @@ int __init acpi_scan_init(void)
 	 * Create the root device in the bus's device tree
 	 */
 	result = acpi_add_single_object(&acpi_root, ACPI_ROOT_OBJECT,
-					ACPI_BUS_TYPE_SYSTEM, &ops);
+					ACPI_BUS_TYPE_DEVICE, &ops);
 	if (result)
 		goto Done;
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b145270..edca7d5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -72,7 +72,6 @@ enum acpi_bus_device_type {
 	ACPI_BUS_TYPE_POWER,
 	ACPI_BUS_TYPE_PROCESSOR,
 	ACPI_BUS_TYPE_THERMAL,
-	ACPI_BUS_TYPE_SYSTEM,
 	ACPI_BUS_TYPE_POWER_BUTTON,
 	ACPI_BUS_TYPE_SLEEP_BUTTON,
 	ACPI_BUS_DEVICE_TYPE_COUNT

