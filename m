From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ACPI / scan: Fix enumeration for special SPI and I2C devices
Date: Thu, 15 Jun 2017 15:40:49 +0300
Message-ID: <20170615124049.19787-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14723 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdFOMkz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jun 2017 08:40:55 -0400
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

Fix this by checking is the device SPI or I2C device and let the code go
through the device_attach() and acpi_default_enumeration() path for all
SPI and I2C devices.

Fixes: f406270bf73d ("ACPI / scan: Set the visited flag for all enumerated devices")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
This should go to linux-stable v4.9+ but it doesn't apply due the commit
f5beabfe6179 ("ACPI / scan: Apply default enumeration to devices with
ACPI drivers"). Should both be queued or have another version from this
for linux-stable?
---
 drivers/acpi/scan.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3a10d7573477..38b9a319b0c4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1745,20 +1745,27 @@ static int acpi_check_spi_i2c_slave(struct acpi_resource *ares, void *data)
 	return -1;
 }
 
-static void acpi_default_enumeration(struct acpi_device *device)
+static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
 {
 	struct list_head resource_list;
 	bool is_spi_i2c_slave = false;
 
-	/*
-	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
-	 * respective parents.
-	 */
 	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
 			       &is_spi_i2c_slave);
 	acpi_dev_free_resource_list(&resource_list);
-	if (!is_spi_i2c_slave) {
+
+	return is_spi_i2c_slave;
+}
+
+static void acpi_default_enumeration(struct acpi_device *device,
+				     bool spi_i2c_slave)
+{
+	/*
+	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
+	 * respective parents.
+	 */
+	if (!spi_i2c_slave) {
 		acpi_create_platform_device(device, NULL);
 		acpi_device_set_enumerated(device);
 	} else {
@@ -1780,7 +1787,7 @@ static int acpi_generic_device_attach(struct acpi_device *adev,
 	 * below can be unconditional.
 	 */
 	if (adev->data.of_compatible)
-		acpi_default_enumeration(adev);
+		acpi_default_enumeration(adev, acpi_is_spi_i2c_slave(adev));
 
 	return 1;
 }
@@ -1823,6 +1830,7 @@ static void acpi_bus_attach(struct acpi_device *device)
 {
 	struct acpi_device *child;
 	acpi_handle ejd;
+	bool spi_i2c_slave;
 	int ret;
 
 	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
@@ -1853,8 +1861,9 @@ static void acpi_bus_attach(struct acpi_device *device)
 	if (ret < 0)
 		return;
 
+	spi_i2c_slave = acpi_is_spi_i2c_slave(device);
 	device->flags.match_driver = true;
-	if (ret > 0) {
+	if (ret > 0 && !spi_i2c_slave) {
 		acpi_device_set_enumerated(device);
 		goto ok;
 	}
@@ -1863,10 +1872,10 @@ static void acpi_bus_attach(struct acpi_device *device)
 	if (ret < 0)
 		return;
 
-	if (device->pnp.type.platform_id)
-		acpi_default_enumeration(device);
-	else
+	if (!device->pnp.type.platform_id && !spi_i2c_slave)
 		acpi_device_set_enumerated(device);
+	else
+		acpi_default_enumeration(device, spi_i2c_slave);
 
  ok:
 	list_for_each_entry(child, &device->children, node)
-- 
2.11.0

