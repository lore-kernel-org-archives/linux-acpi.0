From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 6/6] ACPI video: support buggy BIOSes with _BCQ
	implemented
Date: Wed, 18 Mar 2009 16:27:18 +0800
Message-ID: <1237364838.3826.62.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25127 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbZCRI0r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 04:26:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

Some buggy BIOSes implements _BCQ instead of _BQC.
Male ACPI video driver support these buggy BIOS.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c	2009-03-17 14:54:20.000000000 +0800
+++ linux-2.6/drivers/acpi/video.c	2009-03-17 14:56:17.000000000 +0800
@@ -162,6 +162,7 @@
 	u8 _BCL:1;		/*Query list of brightness control levels supported */
 	u8 _BCM:1;		/*Set the brightness level */
 	u8 _BQC:1;		/* Get current brightness level */
+	u8 _BCQ:1;		/* Some buggy BIOS uses _BCQ instead of _BQC */
 	u8 _DDC:1;		/*Return the EDID for this device */
 	u8 _DCS:1;		/*Return status of output device */
 	u8 _DGS:1;		/*Query graphics state */
@@ -523,8 +524,10 @@
 {
 	acpi_status status = AE_OK;
 
-	if (device->cap._BQC) {
-		status = acpi_evaluate_integer(device->dev->handle, "_BQC",
+	if (device->cap._BQC || device->cap._BCQ) {
+		char *buf = device->cap._BQC ? "_BQC" : "_BCQ";
+
+		status = acpi_evaluate_integer(device->dev->handle, buf,
 						NULL, level);
 		if (ACPI_SUCCESS(status)) {
 			if (device->brightness->flags._BQC_use_index) {
@@ -544,8 +547,8 @@
 			 * ACPI video backlight still works w/ buggy _BQC.
 			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
 			 */
-			ACPI_WARNING((AE_INFO, "Evaluating _BQC failed"));
-			device->cap._BQC = 0;
+			ACPI_WARNING((AE_INFO, "Evaluating %s failed", buf));
+			device->cap._BQC = device->cap._BCQ = 0;
 		}
 	}
 
@@ -861,6 +864,12 @@
 	}
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BQC",&h_dummy1)))
 		device->cap._BQC = 1;
+	else if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCQ",
+				&h_dummy1))) {
+		printk(KERN_WARNING FW_BUG "_BCQ is used instead of _BQC\n");
+		device->cap._BCQ = 1;
+	}
+
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}


