From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/7] Subject: Move detection time of video devices after
	ACPI PCI device setup
Date: Wed, 16 Apr 2008 20:58:52 +0200
Message-ID: <1208372332.1784.346.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39771 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbYDPS6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 14:58:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

Subject: Move detection time of video devices after ACPI PCI device setup

video_bus_match detects the capabilities of a video device.
This must only be done for devices that are physically plugged in and
are not ACPI dummy devices. Therefore you need acpi_get_physical_device
to check whether behind the ACPI device a real struct *device is present.
The relationship/glueing between struct *device and struct *acpi_device
must have been done for that -> move video device testing after it.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/scan.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/scan.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
@@ -1035,8 +1035,6 @@ static void acpi_device_set_id(struct ac
 		   will get autoloaded and the device might still match
 		   against another driver.
 		*/
-		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
-			cid_add(device, ACPI_VIDEO_HID, NULL);
 		else if (ACPI_SUCCESS(acpi_bay_match(device)))
 			cid_add(device, ACPI_BAY_HID, NULL);
 		else if (ACPI_SUCCESS(acpi_dock_match(device)))
@@ -1275,6 +1273,13 @@ acpi_add_single_object(struct acpi_devic
 			device->parent->ops.bind(device);
 	}
 
+	/* Checking for a video device and add its CID must be done
+	 * after pci bind because we also want to detect its capabilities.
+	 * And we only want to detect the capabilities of plugged in devices
+	 */
+	if (ACPI_SUCCESS(acpi_video_bus_match(device)))
+		cid_add(device, ACPI_VIDEO_HID, NULL);
+
       end:
 	if (!result)
 		*child = device;


