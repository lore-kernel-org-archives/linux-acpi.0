From: akpm@osdl.org
Subject: [patch 12/26] ACPI: simplify scan.c coding
Date: Tue, 28 Mar 2006 14:03:38 -0800
Message-ID: <200603282203.k2SM3iIk027683@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:55727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932419AbWC1WDs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:03:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No functional changes; just remove leftover, unused "buffer" and simplify
control flow (no need to remember error values and goto the end, when we can
simply return the value directly).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/scan.c |   36 +++++++++++++-----------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

diff -puN drivers/acpi/scan.c~acpi-simplify-scanc-coding drivers/acpi/scan.c
--- devel/drivers/acpi/scan.c~acpi-simplify-scanc-coding	2006-03-28 14:03:04.000000000 -0800
+++ devel-akpm/drivers/acpi/scan.c	2006-03-28 14:03:04.000000000 -0800
@@ -235,12 +235,9 @@ static int acpi_bus_get_power_flags(stru
 
 int acpi_match_ids(struct acpi_device *device, char *ids)
 {
-	int error = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
 	if (device->flags.hardware_id)
 		if (strstr(ids, device->pnp.hardware_id))
-			goto Done;
+			return 0;
 
 	if (device->flags.compatible_ids) {
 		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
@@ -249,15 +246,10 @@ int acpi_match_ids(struct acpi_device *d
 		/* compare multiple _CID entries against driver ids */
 		for (i = 0; i < cid_list->count; i++) {
 			if (strstr(ids, cid_list->id[i].value))
-				goto Done;
+				return 0;
 		}
 	}
-	error = -ENOENT;
-
-      Done:
-	if (buffer.pointer)
-		acpi_os_free(buffer.pointer);
-	return error;
+	return -ENOENT;
 }
 
 static acpi_status
@@ -639,21 +631,19 @@ EXPORT_SYMBOL(acpi_bus_register_driver);
  */
 int acpi_bus_unregister_driver(struct acpi_driver *driver)
 {
-	int error = 0;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
 
-	if (driver) {
-		acpi_driver_detach(driver);
+	if (!driver)
+		return_VALUE(-EINVAL);
 
-		if (!atomic_read(&driver->references)) {
-			spin_lock(&acpi_device_lock);
-			list_del_init(&driver->node);
-			spin_unlock(&acpi_device_lock);
-		}
-	} else
-		error = -EINVAL;
-	return_VALUE(error);
+	acpi_driver_detach(driver);
+
+	if (!atomic_read(&driver->references)) {
+		spin_lock(&acpi_device_lock);
+		list_del_init(&driver->node);
+		spin_unlock(&acpi_device_lock);
+	}
+	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
_
