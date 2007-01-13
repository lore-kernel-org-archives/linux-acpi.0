From: malattia@linux.it
Subject: [PATCH 11/11] Fix sony_acpi backlight registration and unregistration
Date: Sat, 13 Jan 2007 23:04:41 +0100
Message-ID: <11687258822382-git-send-email-malattia@linux.it>
References: <11687258812893-git-send-email-malattia@linux.it> <1168725881764-git-send-email-malattia@linux.it> <11687258811866-git-send-email-malattia@linux.it> <11687258812417-git-send-email-malattia@linux.it> <11687258812248-git-send-email-malattia@linux.it> <11687258811707-git-send-email-malattia@linux.it> <11687258813214-git-send-email-malattia@linux.it> <1168725881949-git-send-email-malattia@linux.it> <1168725881872-git-send-email-malattia@linux.it> <11687258812443-git-send-email-malattia@linux.it> <11687258813008-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:52602 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXAMWGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:06:09 -0500
In-Reply-To: <11687258813008-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Initialize the current brightness if the driver registration
was successful and unregister the driver in the error exit path.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index c65f589..c01d98d 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -354,9 +354,14 @@ static int sony_acpi_add(struct acpi_device *device)
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
@@ -400,6 +405,9 @@ static int sony_acpi_add(struct acpi_device *device)
 	return 0;
 
 outproc:
+	if (sony_backlight_device)
+		backlight_device_unregister(sony_backlight_device);
+
 	for (item = sony_acpi_values; item->name; ++item)
 		if (item->proc)
 			remove_proc_entry(item->name, acpi_device_dir(device));
-- 
1.4.4.2

