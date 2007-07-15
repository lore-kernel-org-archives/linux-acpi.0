From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 4/7] Invoke _INI for SNC devices that provide it
Date: Mon, 16 Jul 2007 02:34:36 +0900
Message-ID: <11845208794064-git-send-email-malattia@linux.it>
References: <1184520879452-git-send-email-malattia@linux.it>
 <1184520879991-git-send-email-malattia@linux.it>
 <11845208793336-git-send-email-malattia@linux.it>
 <11845208793678-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi16.ns.itscom.net ([219.110.2.186]:45448 "EHLO
	mtoichi16.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759685AbXGORfK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 13:35:10 -0400
In-Reply-To: <11845208793678-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index ecac39b..4b15f0c 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -864,6 +864,15 @@ static int sony_nc_add(struct acpi_device *device)
 
 	sony_nc_acpi_handle = device->handle;
 
+	/* read device status */
+	result = acpi_bus_get_status(device);
+	/* bail IFF the above call was successful and the device is not present */
+	if (!result && !device->status.present) {
+		dprintk("Device not present\n");
+		result = -ENODEV;
+		goto outwalk;
+	}
+
 	if (debug) {
 		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_nc_acpi_handle,
 					     1, sony_walk_callback, NULL, NULL);
@@ -874,6 +883,15 @@ static int sony_nc_add(struct acpi_device *device)
 		}
 	}
 
+	/* try to _INI the device if such method exists (ACPI spec 3.0-6.5.1
+	 * should be respected as we already checked for the device presence above */
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, METHOD_NAME__INI, &handle))) {
+		dprintk("Invoking _INI\n");
+		if (ACPI_FAILURE(acpi_evaluate_object(sony_nc_acpi_handle, METHOD_NAME__INI,
+						NULL, NULL)))
+			dprintk("_INI Method failed\n");
+	}
+
 	/* setup input devices and helper fifo */
 	result = sony_laptop_setup_input();
 	if (result) {
@@ -886,7 +904,7 @@ static int sony_nc_add(struct acpi_device *device)
 					     ACPI_DEVICE_NOTIFY,
 					     sony_acpi_notify, NULL);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_WARNING DRV_PFX "unable to install notify handler\n");
+		printk(KERN_WARNING DRV_PFX "unable to install notify handler (%u)\n", status);
 		result = -ENODEV;
 		goto outinput;
 	}
-- 
1.5.2.3

