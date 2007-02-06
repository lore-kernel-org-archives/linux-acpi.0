From: akpm@linux-foundation.org
Subject: [patch 13/13] sony_acpi: fix sony_acpi backlight registration and unregistration
Date: Mon, 05 Feb 2007 16:09:19 -0800
Message-ID: <200702060010.l160AMUf003757@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:40708 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965161AbXBFALx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 19:11:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, malattia@linux.it

From: Mattia Dongili <malattia@linux.it>

Initialize the current brightness if the driver registration was successful
and unregister the driver in the error exit path.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sony_acpi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/acpi/sony_acpi.c~sony_acpi-fix-sony_acpi-backlight-registration-and-unregistration drivers/acpi/sony_acpi.c
--- a/drivers/acpi/sony_acpi.c~sony_acpi-fix-sony_acpi-backlight-registration-and-unregistration
+++ a/drivers/acpi/sony_acpi.c
@@ -354,9 +354,14 @@ static int sony_acpi_add(struct acpi_dev
 	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
 					NULL, &sony_backlight_properties);
+
 	        if (IS_ERR(sony_backlight_device)) {
         	        printk(LOG_PFX "unable to register backlight device\n");
+			sony_backlight_device = NULL;
 		}
+		else
+			sony_backlight_properties.brightness =
+				sony_backlight_get_brightness(sony_backlight_device);
 	}
 
 	for (item = sony_acpi_values; item->name; ++item) {
@@ -400,6 +405,9 @@ static int sony_acpi_add(struct acpi_dev
 	return 0;
 
 outproc:
+	if (sony_backlight_device)
+		backlight_device_unregister(sony_backlight_device);
+
 	for (item = sony_acpi_values; item->name; ++item)
 		if (item->proc)
 			remove_proc_entry(item->name, acpi_device_dir(device));
_
