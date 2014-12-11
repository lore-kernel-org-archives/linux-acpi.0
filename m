From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH] mfd: dln2: add support for ACPI
Date: Thu, 11 Dec 2014 18:32:07 +0200
Message-ID: <1418315527-19492-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37153 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933324AbaLKQc1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Dec 2014 11:32:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-usb@vger.kernel.org, lee.jones@linaro.org, johan@kernel.org, Octavian Purdila <octavian.purdila@intel.com>

This patch adds support to load a custom ACPI table that describes
devices connected via the DLN2 USB to I2C/SPI/GPIO bridge.

The ACPI table is loaded at runtime as firmware with the name
dln2.aml, it looks for an ACPI device entry with _HID set to
"DLN20000" and makes it the ACPI companion for DLN2 USB sub-drivers.

It is sort of a hack due to the "../acpi/internal.h" and
"../usb/core/usb.h" includes and perhaps something more generic would
be more appropriate. Any suggestions to the right direction are kindly
appreciated.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Documentation/acpi/dln2-acpi.txt |  48 ++++++++++++++++++
 drivers/mfd/Kconfig              |  11 +++++
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/dln2-acpi.c          | 103 +++++++++++++++++++++++++++++++++++++++
 drivers/mfd/dln2.c               |   6 +--
 drivers/mfd/dln2.h               |   9 ++++
 6 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/acpi/dln2-acpi.txt
 create mode 100644 drivers/mfd/dln2-acpi.c
 create mode 100644 drivers/mfd/dln2.h

diff --git a/Documentation/acpi/dln2-acpi.txt b/Documentation/acpi/dln2-acpi.txt
new file mode 100644
index 0000000..c099241
--- /dev/null
+++ b/Documentation/acpi/dln2-acpi.txt
@@ -0,0 +1,48 @@
+Diolan DLN2 custom APCI table
+
+The Diolan DLN2 is an USB to I2C/SPI/GPIO bridge and as such it can be used to
+connect to various I2C or SPI devices. Because these busses lack an enumeration
+protocol, the driver obtains various information about the device (such as I2C
+address and GPIO pins) from either ACPI or device tree.
+
+To allow using such devices connect to the DLN2 bridge to their full extend
+(e.g. interrupt mode), if CONFIG_MFD_DLN2_ACPI option has been compiled in the
+kernel, the user can define a custom ACPI table that will be dynamically loaded
+at boot time from firmware paths. The ACPI table filename must be dln2.aml and
+it must contain a root device with _HID set "DLN20000".
+
+Here is a example of how the ACPI table should look like:
+
+DefinitionBlock ("ssdt.aml", "SSDT", 1, "INTEL ", "CpuDptf", 0x00000003)
+{
+	Device (DLN0)
+	{
+		Name (_ADR, Zero)
+		Name (_HID, "DLN2000")
+
+		Device (STAC)
+		{
+			Name (_ADR, Zero)
+			Name (_HID, "BMC150A")
+			Name (_CID, "INTACCL")
+			Name (_UID, One)
+
+			Method (_CRS, 0, Serialized)
+			{
+				Name (RBUF, ResourceTemplate ()
+				{
+					I2cSerialBus (0x0010, ControllerInitiated, 0x00061A80,
+						      AddressingMode7Bit, "\\DLN0",
+						      0x00, ResourceConsumer, ,)
+
+					GpioInt (Level, ActiveHigh, Exclusive, PullDown, 0x0000,
+						 "\\DLN0", 0x00, ResourceConsumer, , )
+					{ // Pin list
+						0
+					}
+				})
+				Return (RBUF)
+		       }
+		}
+	}
+}
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2e6b731..b810195 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -205,6 +205,17 @@ config MFD_DLN2
 	  etc. must be enabled in order to use the functionality of
 	  the device.
 
+config MFD_DLN2_ACPI
+	bool "Diolan DLN2 ACPI support"
+	depends on MFD_DLN2 && ACPI
+	default n
+	help
+	  Say yes here to add ACPI support to DLN2 which allows loading a custom
+	  ACPI table to describe devices between the DLN2 I2C or SPI bridge as
+	  well as GPIO support for those devices. See
+	  Documentation/acpi/dln2-acpi.txt for more information.
+
+
 config MFD_MC13XXX
 	tristate
 	depends on (SPI_MASTER || I2C)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 53467e2..dbe1f3f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -176,6 +176,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
+obj-$(CONFIG_MFD_DLN2_ACPI)	+= dln2-acpi.o
 
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
diff --git a/drivers/mfd/dln2-acpi.c b/drivers/mfd/dln2-acpi.c
new file mode 100644
index 0000000..8c99769
--- /dev/null
+++ b/drivers/mfd/dln2-acpi.c
@@ -0,0 +1,103 @@
+#define pr_fmt(fmt) "dln2-acpi: " fmt
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/firmware.h>
+#include "../acpi/internal.h"
+#include "../usb/core/usb.h"
+#include "dln2.h"
+
+static acpi_handle dln2_acpi_handle = NULL;
+static const struct firmware *dln2_acpi;
+
+static bool dln2_acpi_bus_match(struct device *dev)
+{
+	struct usb_interface *intf;
+	struct usb_device *udev;
+	u16 idVendor, idProduct;
+	int i;
+
+	if (is_usb_endpoint(dev) || !dev->parent ||
+	    !is_usb_interface(dev->parent))
+		return false;
+
+	intf = to_usb_interface(dev->parent);
+	udev = interface_to_usbdev(intf);
+	idVendor = le16_to_cpu(udev->descriptor.idVendor);
+	idProduct = le16_to_cpu(udev->descriptor.idProduct);
+
+	for (i = 0; i < ARRAY_SIZE(dln2_table); i++)
+		if (idVendor == dln2_table[i].idVendor &&
+		    idProduct == dln2_table[i].idProduct)
+			return true;
+
+	return false;
+}
+
+static struct acpi_device *dln2_acpi_find_companion(struct device *dev)
+{
+	struct acpi_device *adev;
+	int ret;
+
+	ret = acpi_bus_get_device(dln2_acpi_handle, &adev);
+	if (ret) {
+		pr_err("failed to get device: %d\n", ret);
+		return NULL;
+	}
+
+	return adev;
+}
+
+static struct acpi_bus_type dln2_acpi_bus = {
+	.name = "DNL2",
+	.match = dln2_acpi_bus_match,
+	.find_companion = dln2_acpi_find_companion,
+};
+
+static acpi_status dln2_find_acpi_handle(acpi_handle handle, u32 level,
+					 void *ctxt, void **retv)
+{
+	acpi_handle *dln2_handle = (acpi_handle *)retv;
+
+	*dln2_handle = handle;
+
+	return AE_CTRL_TERMINATE;
+}
+
+static int dln2_acpi_init(void)
+{
+	int ret;
+
+	request_firmware_direct(&dln2_acpi, "dln2.aml", NULL);
+	if (dln2_acpi) {
+		struct acpi_table_header *acpi_table = (void *)dln2_acpi->data;
+
+		ret = acpi_load_table(acpi_table);
+		if (ret) {
+			pr_err("invalid ACPI table\n");
+			release_firmware(dln2_acpi);
+		}
+	}
+
+	acpi_get_devices("DLN20000", dln2_find_acpi_handle, NULL, &dln2_acpi_handle);
+	if (!dln2_acpi_handle)
+		return -ENODEV;
+
+	if (dln2_acpi)
+		acpi_bus_scan(dln2_acpi_handle);
+
+	return register_acpi_bus_type(&dln2_acpi_bus);
+}
+
+static void dln2_acpi_exit(void)
+{
+	release_firmware(dln2_acpi);
+	unregister_acpi_bus_type(&dln2_acpi_bus);
+}
+
+module_init(dln2_acpi_init);
+module_exit(dln2_acpi_exit);
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 08c403c..62120e7 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/dln2.h>
 #include <linux/rculist.h>
+#include "dln2.h"
 
 struct dln2_header {
 	__le16 size;
@@ -768,11 +769,6 @@ out_cleanup:
 	return ret;
 }
 
-static const struct usb_device_id dln2_table[] = {
-	{ USB_DEVICE(0xa257, 0x2013) },
-	{ }
-};
-
 MODULE_DEVICE_TABLE(usb, dln2_table);
 
 static int dln2_suspend(struct usb_interface *iface, pm_message_t message)
diff --git a/drivers/mfd/dln2.h b/drivers/mfd/dln2.h
new file mode 100644
index 0000000..1ed4272
--- /dev/null
+++ b/drivers/mfd/dln2.h
@@ -0,0 +1,9 @@
+#ifndef _MFD_DLN2_H
+#define _MFD_DLN2_H
+
+static const struct usb_device_id dln2_table[] = {
+	{ USB_DEVICE(0xa257, 0x2013) },
+	{ }
+};
+
+#endif /* _MFD_DLN2_H */
-- 
1.9.1

