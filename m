From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 09/19] ACPI: remove acpi_device_set_context() "type" argument
Date: Mon, 31 Aug 2009 16:32:51 -0600
Message-ID: <20090831223251.11814.11020.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:6026 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZHaWco (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:32:44 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We only pass the "type" to acpi_device_set_context() so we know whether
the device has a handle to which we can attach the acpi_device pointer.
But it's safer to just check for the handle directly, since it's in the
acpi_device already.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 06c1c06..42324a0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1164,29 +1164,27 @@ static void acpi_device_set_id(struct acpi_device *device, int type)
 	kfree(info);
 }
 
-static int acpi_device_set_context(struct acpi_device *device, int type)
+static int acpi_device_set_context(struct acpi_device *device)
 {
-	acpi_status status = AE_OK;
-	int result = 0;
+	acpi_status status;
+
 	/*
 	 * Context
 	 * -------
 	 * Attach this 'struct acpi_device' to the ACPI object.  This makes
-	 * resolutions from handle->device very efficient.  Note that we need
-	 * to be careful with fixed-feature devices as they all attach to the
-	 * root object.
+	 * resolutions from handle->device very efficient.  Fixed hardware
+	 * devices have no handles, so we skip them.
 	 */
-	if (type != ACPI_BUS_TYPE_POWER_BUTTON &&
-	    type != ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		status = acpi_attach_data(device->handle,
-					  acpi_bus_data_handler, device);
+	if (!device->handle)
+		return 0;
 
-		if (ACPI_FAILURE(status)) {
-			printk(KERN_ERR PREFIX "Error attaching device data\n");
-			result = -ENODEV;
-		}
-	}
-	return result;
+	status = acpi_attach_data(device->handle,
+				  acpi_bus_data_handler, device);
+	if (ACPI_SUCCESS(status))
+		return 0;
+
+	printk(KERN_ERR PREFIX "Error attaching device data\n");
+	return -ENODEV;
 }
 
 static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
@@ -1307,7 +1305,7 @@ acpi_add_single_object(struct acpi_device **child,
 	 * the corresponding ACPI device by the acpi handle in the course
 	 * of getting the power/wakeup/performance flags.
 	 */
-	result = acpi_device_set_context(device, type);
+	result = acpi_device_set_context(device);
 	if (result)
 		goto end;
 

