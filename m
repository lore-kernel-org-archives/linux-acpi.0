From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/33] ACPI / PM: Register power resource devices as soon as
 they are needed
Date: Sun, 26 Dec 2010 17:43:32 -0500
Message-ID: <79eeab08db8f874d41d50a12051eabfcdd7a16f6.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51680 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab0LZW6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:50 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:49 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Depending on the organization of the ACPI namespace, power resource
device objects may generally be scanned after the "regular" device
objects that they are referred from through _PRn.  This, in turn, may
cause acpi_bus_get_power_flags() to attempt to access them through
acpi_bus_init_power() before they are registered (and initialized by
acpi_power_driver).  [This is not a theoretical issue, it actually
happens for one PnP device on my testbed HP nx6325.]

To fix this problem, make acpi_bus_get_power_flags() attempt to
register power resource devices as soon as they have been found in
the _PRn output for any other devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 06b5f29..66d924c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -827,6 +827,8 @@ end:
 	return 0;
 }
 
+static void acpi_bus_add_power_resource(acpi_handle handle);
+
 static int acpi_bus_get_power_flags(struct acpi_device *device)
 {
 	acpi_status status = 0;
@@ -855,8 +857,12 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
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
@@ -1303,6 +1309,20 @@ end:
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
-- 
1.7.3.3.557.gb5c17

