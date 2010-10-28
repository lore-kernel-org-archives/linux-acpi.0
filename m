From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 2/3] ACPI / PM: Register power resource devices as soon as they are needed
Date: Thu, 28 Oct 2010 15:10:13 +0200
Message-ID: <201010281510.13797.rjw@sisk.pl>
References: <201010281507.34994.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33291 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758691Ab0J1NNH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Oct 2010 09:13:07 -0400
In-Reply-To: <201010281507.34994.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Depending on the organization of the ACPI namespace, power resource
device objects may generally be scanned after the "regular" device
objects they are referred from through _PRn.  This, in turn, may
cause acpi_bus_get_power_flags() to attempt to access them through
acpi_bus_get_power() before they are registered (and initialized by
acpi_power_driver).  In those cases, acpi_bus_get_power() called by
acpi_bus_get_power() will fail.

To fix this problem, make acpi_bus_get_power_flags() attempt to
register power resource devices as soon as they have been found in
the _PRn output for any other devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -818,6 +818,8 @@ end:
 	return 0;
 }
 
+static void acpi_bus_add_power_resource(acpi_handle handle);
+
 static int acpi_bus_get_power_flags(struct acpi_device *device)
 {
 	acpi_status status = 0;
@@ -846,8 +848,12 @@ static int acpi_bus_get_power_flags(stru
 		acpi_evaluate_reference(device->handle, object_name, NULL,
 					&ps->resources);
 		if (ps->resources.count) {
+			int j;
+
 			device->power.flags.power_resources = 1;
 			ps->flags.valid = 1;
+			for (j = 0; j < ps->resources.count; j++)
+				acpi_bus_add_power_resource(ps->resources.handles[j]);
 		}
 
 		/* Evaluate "_PSx" to see if we can do explicit sets */
@@ -1304,6 +1310,20 @@ end:
 #define ACPI_STA_DEFAULT (ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED | \
 			  ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING)
 
+static void acpi_bus_add_power_resource(acpi_handle handle)
+{
+	struct acpi_bus_ops ops = {
+		.acpi_op_add = 1,
+		.acpi_op_start = 1,
+	};
+	struct acpi_device *device = NULL;
+
+	acpi_bus_get_device(handle, &device);
+	if (!device)
+		acpi_add_single_object(&device, handle, ACPI_BUS_TYPE_POWER,
+					ACPI_STA_DEFAULT, &ops);
+}
+
 static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 				    unsigned long long *sta)
 {

