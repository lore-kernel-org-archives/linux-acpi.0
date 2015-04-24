From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH] ACPI / scan: Add a scan handler for PRP0001
Date: Fri, 24 Apr 2015 02:15:22 +0200
Message-ID: <2014594.ptBLVGNNCY@vostro.rjw.lan>
References: <3444888.xxxTREorHY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56433 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030875AbbDWXuj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2015 19:50:39 -0400
In-Reply-To: <3444888.xxxTREorHY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the special PRP0001 device ID is present in the given device's list
of ACPI/PNP IDs and the device has a valid "compatible" property in
the _DSD, it should be enumerated using the default mechanism,
unless some scan handlers match the IDs preceding PRP0001 in the
device's list of ACPI/PNP IDs.  In addition to that, no scan handlers
matching the IDs following PRP0001 in that list should be attached
to the device.

To make that happen, define a scan handler that will match PRP0001
and trigger the default enumeration for the matching devices if the
"compatible" property is present for them.

Since that requires the check for platform_id and device->handler
to be removed from acpi_default_enumeration(), move the fallback
invocation of acpi_default_enumeration() to acpi_bus_attach()
(after it's checked if there's a matching ACPI driver for the
device), which is a better place to call it, and do the platform_id
check in there too (device->handler is guaranteed to be unset at
the point where the function is looking for a matching ACPI driver).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Darren Hart <dvhart@linux.intel.com>
---

The change from the original patch is to change the scan handler
behavior to make it return 1 also if the "compatible" property is
not present, in which case the additional scan handlers should not
trigger too *and* the default enumeration should not trigger either
(as there's no ID to match to), which will allow things like
auxiliary nodes (think GPIO buttons/LEDs etc) to be easily represented.

Darren, I've tentatively added your Acked-by tag to this one, please
let me know if that's not appropriate.

Rafael


---
 drivers/acpi/scan.c |   33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2388,9 +2388,6 @@ static void acpi_default_enumeration(str
 	struct list_head resource_list;
 	bool is_spi_i2c_slave = false;
 
-	if (!device->pnp.type.platform_id || device->handler)
-		return;
-
 	/*
 	 * Do not enemerate SPI/I2C slaves as they will be enuerated by their
 	 * respective parents.
@@ -2403,6 +2400,29 @@ static void acpi_default_enumeration(str
 		acpi_create_platform_device(device);
 }
 
+static const struct acpi_device_id generic_device_ids[] = {
+	{"PRP0001", },
+	{"", },
+};
+
+static int acpi_generic_device_attach(struct acpi_device *adev,
+				      const struct acpi_device_id *not_used)
+{
+	/*
+	 * Since PRP0001 is the only ID handled here, the test below can be
+	 * unconditional.
+	 */
+	if (adev->data.of_compatible)
+		acpi_default_enumeration(adev);
+
+	return 1;
+}
+
+static struct acpi_scan_handler generic_device_handler = {
+	.ids = generic_device_ids,
+	.attach = acpi_generic_device_attach,
+};
+
 static int acpi_scan_attach_handler(struct acpi_device *device)
 {
 	struct acpi_hardware_id *hwid;
@@ -2428,8 +2448,6 @@ static int acpi_scan_attach_handler(stru
 				break;
 		}
 	}
-	if (!ret)
-		acpi_default_enumeration(device);
 
 	return ret;
 }
@@ -2471,6 +2489,9 @@ static void acpi_bus_attach(struct acpi_
 		ret = device_attach(&device->dev);
 		if (ret < 0)
 			return;
+
+		if (!ret && device->pnp.type.platform_id)
+			acpi_default_enumeration(device);
 	}
 	device->flags.visited = true;
 
@@ -2629,6 +2650,8 @@ int __init acpi_scan_init(void)
 	acpi_pnp_init();
 	acpi_int340x_thermal_init();
 
+	acpi_scan_add_handler(&generic_device_handler);
+
 	mutex_lock(&acpi_scan_lock);
 	/*
 	 * Enumerate devices in the ACPI namespace.

