From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 12/26] ACPI: simplify scan.c coding
Date: Sun, 2 Apr 2006 00:21:50 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DEA@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58269 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751222AbWDBFVx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:21:53 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bjorn.helgaas@hp.com
>Subject: [patch 12/26] ACPI: simplify scan.c coding
>
>
>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>No functional changes; just remove leftover, unused "buffer" 
>and simplify
>control flow (no need to remember error values and goto the 
>end, when we can
>simply return the value directly).
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/scan.c |   36 +++++++++++++-----------------------
> 1 files changed, 13 insertions(+), 23 deletions(-)
>
>diff -puN drivers/acpi/scan.c~acpi-simplify-scanc-coding 
>drivers/acpi/scan.c
>--- devel/drivers/acpi/scan.c~acpi-simplify-scanc-coding	
>2006-03-28 14:03:04.000000000 -0800
>+++ devel-akpm/drivers/acpi/scan.c	2006-03-28 
>14:03:04.000000000 -0800
>@@ -235,12 +235,9 @@ static int acpi_bus_get_power_flags(stru
> 
> int acpi_match_ids(struct acpi_device *device, char *ids)
> {
>-	int error = 0;
>-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>-
> 	if (device->flags.hardware_id)
> 		if (strstr(ids, device->pnp.hardware_id))
>-			goto Done;
>+			return 0;
> 
> 	if (device->flags.compatible_ids) {
> 		struct acpi_compatible_id_list *cid_list = 
>device->pnp.cid_list;
>@@ -249,15 +246,10 @@ int acpi_match_ids(struct acpi_device *d
> 		/* compare multiple _CID entries against driver ids */
> 		for (i = 0; i < cid_list->count; i++) {
> 			if (strstr(ids, cid_list->id[i].value))
>-				goto Done;
>+				return 0;
> 		}
> 	}
>-	error = -ENOENT;
>-
>-      Done:
>-	if (buffer.pointer)
>-		acpi_os_free(buffer.pointer);
>-	return error;
>+	return -ENOENT;
> }
> 
> static acpi_status
>@@ -639,21 +631,19 @@ EXPORT_SYMBOL(acpi_bus_register_driver);
>  */
> int acpi_bus_unregister_driver(struct acpi_driver *driver)
> {
>-	int error = 0;
>-
> 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
> 
>-	if (driver) {
>-		acpi_driver_detach(driver);
>+	if (!driver)
>+		return_VALUE(-EINVAL);
> 
>-		if (!atomic_read(&driver->references)) {
>-			spin_lock(&acpi_device_lock);
>-			list_del_init(&driver->node);
>-			spin_unlock(&acpi_device_lock);
>-		}
>-	} else
>-		error = -EINVAL;
>-	return_VALUE(error);
>+	acpi_driver_detach(driver);
>+
>+	if (!atomic_read(&driver->references)) {
>+		spin_lock(&acpi_device_lock);
>+		list_del_init(&driver->node);
>+		spin_unlock(&acpi_device_lock);
>+	}
>+	return_VALUE(0);
> }
> 
> EXPORT_SYMBOL(acpi_bus_unregister_driver);
>_
>
