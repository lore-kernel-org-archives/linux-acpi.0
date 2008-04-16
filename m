From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/7] ACPI: Cleanup: Remove unneeded, multiple local dummy
	variables
Date: Wed, 16 Apr 2008 20:52:02 +0200
Message-ID: <1208371922.1784.341.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:38424 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbYDPSwG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 14:52:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>, Egbert Eich <eich@suse.de>, "Barnes, Jesse" <jesse.barnes@intel.com>

ACPI: Cleanup: Remove unneeded, multiple local dummy variables

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/scan.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/scan.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
@@ -882,10 +882,7 @@ static void acpi_device_get_busid(struct
 static int
 acpi_video_bus_match(struct acpi_device *device)
 {
-	acpi_handle h_dummy1;
-	acpi_handle h_dummy2;
-	acpi_handle h_dummy3;
-
+	acpi_handle h_dummy;
 
 	if (!device)
 		return -EINVAL;
@@ -895,18 +892,18 @@ acpi_video_bus_match(struct acpi_device 
 	 */
 
 	/* Does this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy2)))
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
 		return 0;
 
 	/* Does this device able to retrieve a video ROM ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy1)))
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy)))
 		return 0;
 
 	/* Does this device able to configure which video head to be POSTed ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy2)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy3)))
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy)))
 		return 0;
 
 	return -ENODEV;


