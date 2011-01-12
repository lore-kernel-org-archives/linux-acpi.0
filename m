From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/48] ACPI / PM: Register power resource devices as soon as
 they are needed
Date: Wed, 12 Jan 2011 05:19:33 -0500
Message-ID: <bf325f9538d8c89312be305b9779edbcb436af00.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1ALRAl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:41 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:36 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
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
index 2951a27..cb7956c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -847,6 +847,8 @@ end:
 	return 0;
 }
 
+static void acpi_bus_add_power_resource(acpi_handle handle);
+
 static int acpi_bus_get_power_flags(struct acpi_device *device)
 {
 	acpi_status status = 0;
@@ -875,8 +877,12 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
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
@@ -1323,6 +1329,20 @@ end:
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
1.7.4.rc1.7.g2cf08

