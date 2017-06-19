From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2] ACPI / scan: Fix enumeration for special SPI and I2C devices
Date: Mon, 19 Jun 2017 15:53:01 +0300
Message-ID: <20170619125301.7016-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:58415 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbdFSMxH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jun 2017 08:53:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Commit f406270bf73d ("ACPI / scan: Set the visited flag for all
enumerated devices") caused that two group of special SPI or I2C
devices do not enumerate. SPI and I2C devices are expected to be
enumerated by the SPI and I2C subsystems but change caused that
acpi_bus_attach() marks those devices with acpi_device_set_enumerated().

First group of devices are matched using Device Tree compatible property
with special _HID "PRP0001". Those devices have matched scan handler,
acpi_scan_attach_handler() retuns 1 and acpi_bus_attach() marks them
with acpi_device_set_enumerated().

Second group of devices without valid _HID such as "LNXVIDEO" have
device->pnp.type.platform_id set to zero and change again marks them
with acpi_device_set_enumerated().

Fix this by flagging the SPI and I2C devices during struct acpi_device
object initialization time and let the code in acpi_bus_attach() to go
through the device_attach() and acpi_default_enumeration() path for all
SPI and I2C devices.

Fixes: f406270bf73d ("ACPI / scan: Set the visited flag for all enumerated devices")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
v2:
Use Mika's idea of flagging the acpi_device.
v1:
This should go to linux-stable v4.9+ but it doesn't apply due the commit
f5beabfe6179 ("ACPI / scan: Apply default enumeration to devices with
ACPI drivers"). Should both be queued or have another version from this
for linux-stable?
---
 drivers/acpi/scan.c     | 67 +++++++++++++++++++++++++++----------------------
 include/acpi/acpi_bus.h |  3 ++-
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3a10d7573477..d53162997f32 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1428,6 +1428,37 @@ static void acpi_init_coherency(struct acpi_device *adev)
 	adev->flags.coherent_dma = cca;
 }
 
+static int acpi_check_spi_i2c_slave(struct acpi_resource *ares, void *data)
+{
+	bool *is_spi_i2c_slave_p = data;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	/*
+	 * devices that are connected to UART still need to be enumerated to
+	 * platform bus
+	 */
+	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
+		*is_spi_i2c_slave_p = true;
+
+	 /* no need to do more checking */
+	return -1;
+}
+
+static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
+{
+	struct list_head resource_list;
+	bool is_spi_i2c_slave = false;
+
+	INIT_LIST_HEAD(&resource_list);
+	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
+			       &is_spi_i2c_slave);
+	acpi_dev_free_resource_list(&resource_list);
+
+	return is_spi_i2c_slave;
+}
+
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 			     int type, unsigned long long sta)
 {
@@ -1443,6 +1474,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	acpi_bus_get_flags(device);
 	device->flags.match_driver = false;
 	device->flags.initialized = true;
+	device->flags.spi_i2c_slave = acpi_is_spi_i2c_slave(device);
 	acpi_device_clear_enumerated(device);
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
@@ -1727,38 +1759,13 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
 	return AE_OK;
 }
 
-static int acpi_check_spi_i2c_slave(struct acpi_resource *ares, void *data)
-{
-	bool *is_spi_i2c_slave_p = data;
-
-	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
-		return 1;
-
-	/*
-	 * devices that are connected to UART still need to be enumerated to
-	 * platform bus
-	 */
-	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
-		*is_spi_i2c_slave_p = true;
-
-	 /* no need to do more checking */
-	return -1;
-}
-
 static void acpi_default_enumeration(struct acpi_device *device)
 {
-	struct list_head resource_list;
-	bool is_spi_i2c_slave = false;
-
 	/*
 	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
 	 * respective parents.
 	 */
-	INIT_LIST_HEAD(&resource_list);
-	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
-			       &is_spi_i2c_slave);
-	acpi_dev_free_resource_list(&resource_list);
-	if (!is_spi_i2c_slave) {
+	if (!device->flags.spi_i2c_slave) {
 		acpi_create_platform_device(device, NULL);
 		acpi_device_set_enumerated(device);
 	} else {
@@ -1854,7 +1861,7 @@ static void acpi_bus_attach(struct acpi_device *device)
 		return;
 
 	device->flags.match_driver = true;
-	if (ret > 0) {
+	if (ret > 0 && !device->flags.spi_i2c_slave) {
 		acpi_device_set_enumerated(device);
 		goto ok;
 	}
@@ -1863,10 +1870,10 @@ static void acpi_bus_attach(struct acpi_device *device)
 	if (ret < 0)
 		return;
 
-	if (device->pnp.type.platform_id)
-		acpi_default_enumeration(device);
-	else
+	if (!device->pnp.type.platform_id && !device->flags.spi_i2c_slave)
 		acpi_device_set_enumerated(device);
+	else
+		acpi_default_enumeration(device);
 
  ok:
 	list_for_each_entry(child, &device->children, node)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 197f3fffc9a7..408c7820e200 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -210,7 +210,8 @@ struct acpi_device_flags {
 	u32 of_compatible_ok:1;
 	u32 coherent_dma:1;
 	u32 cca_seen:1;
-	u32 reserved:20;
+	u32 spi_i2c_slave:1;
+	u32 reserved:19;
 };
 
 /* File System */
-- 
2.11.0

