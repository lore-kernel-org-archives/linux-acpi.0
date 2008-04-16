From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 5/7] Detect ACPI BIOS brightness capabilities early
Date: Wed, 16 Apr 2008 21:01:42 +0200
Message-ID: <1208372502.1784.350.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:45814 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbYDPTBo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 15:01:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

Detect ACPI BIOS brightness capabilities early

Detect whether an ACPI graphics device supports ACPI video
or the Integrated Graphics Device (IGD) extensions.
Only check physically plugged, not the dummy devices.
Depending on whether the kernel supports the IGD device, drivers
can decide whether native vendor specific or a generic driver should
take brightness or display switching control.

Introduce a boot parameter: acpi_brightness_by_vendor
If set, the ACPI video driver will not control brightness

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/scan.c  |   95 +++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/acpi.h |    9 ++++
 2 files changed, 97 insertions(+), 7 deletions(-)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/scan.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
@@ -879,10 +879,61 @@ static void acpi_device_get_busid(struct
 	}
 }
 
+/*
+ * Indicates which video capabilities are available in BIOS and follow the
+ * ACPI spec.
+ * If CONFIG_ACPI_VIDEO is not defined, the variable stays 0 and vendor
+ * specific drivers will always take over..., otherwise they want to take
+ * over some parts, e.g. if we have an IGD device, but no IGD driver yet,
+ * or if user explicitly requests native driver brightness support
+*/
+u8 acpi_video_support;
+EXPORT_SYMBOL(acpi_video_support);
+
+#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
+
+static int __init acpi_brightness_force_vendor(char *str)
+{
+	acpi_video_support &= ACPI_VIDEO_FORCE_VENDOR_SPECIFIC;
+	return 1;
+}
+__setup("acpi_video_by_vendor", acpi_brightness_force_vendor);
+
+static acpi_status
+acpi_brightness_cap_match(acpi_handle handle, u32 level, void *context,
+			  void **return_value)
+{
+       acpi_handle h_dummy;
+
+       if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy)) &&
+	   ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy))) {
+	       printk(KERN_INFO "Brightness switching support detected\n");
+	       acpi_video_support |= ACPI_VIDEO_BRIGHTNESS;
+	       return 0;
+       }
+       return -ENODEV;
+}
+
+static void acpi_video_igd_match(struct acpi_device *device)
+{
+
+	acpi_handle h_dummy;
+
+	/* We should check for all mandatory IGD functions here */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DRDY", &h_dummy))) {
+		acpi_video_support |= ACPI_VIDEO_IGD;
+	}
+}
+
+/*
+ * If this one returns 0, the device will be marked as a video device
+ * and the ACPI video driver module will be autoloaded
+ */
 static int
 acpi_video_bus_match(struct acpi_device *device)
 {
 	acpi_handle h_dummy;
+	struct device *dev;
 
 	if (!device)
 		return -EINVAL;
@@ -893,22 +944,52 @@ acpi_video_bus_match(struct acpi_device 
 
 	/* Does this device able to support video switching ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
-		return 0;
-
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy))) {
+		acpi_video_support |= ACPI_VIDEO_OUTPUT_SWITCHING;
+		goto success;
+	}
 	/* Does this device able to retrieve a video ROM ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy)))
-		return 0;
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy))) {
+		acpi_video_support |= ACPI_VIDEO_ROM_AVAILABLE;
+		goto success;
+	}
 
 	/* Does this device able to configure which video head to be POSTed ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy)) &&
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy)))
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy))) {
+		acpi_video_support |= ACPI_VIDEO_DEVICE_POSTING;
+		goto success;
+	}
+	return -ENODEV;
+
+ success:
+	dev = acpi_get_physical_pci_device(device->handle);
+	if (!dev)
+		/* An ACPI dummy device, no card is plugged in, still return
+		 * true so that this device can later be identified as a video
+		 * device via CID list
+		 */
 		return 0;
+	put_device(dev);
 
-	return -ENODEV;
+	/* This device is a video device which is really plugged in,
+	   now also check for IGD and brightness support */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle, ACPI_UINT32_MAX,
+			    acpi_brightness_cap_match, NULL, NULL);
+	/* IGD testing might not be necessary if no brightness functions
+	   are available */
+	acpi_video_igd_match(device);
+	return 0;
 }
 
+#else /* CONFIG_ACPI_VIDEO || CONFIG_ACPI_VIDEO_MODULE */
+
+static int
+acpi_video_bus_match(struct acpi_device *device) { return 0; }
+
+#endif
+
 /*
  * acpi_bay_match - see if a device is an ejectable driver bay
  *
Index: linux-acpi-2.6_video_native_vs_vendor/include/linux/acpi.h
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/include/linux/acpi.h
+++ linux-acpi-2.6_video_native_vs_vendor/include/linux/acpi.h
@@ -169,6 +169,15 @@ struct acpi_pci_driver {
 int acpi_pci_register_driver(struct acpi_pci_driver *driver);
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
 
+/* video/brightness support */
+#define ACPI_VIDEO_OUTPUT_SWITCHING		1
+#define ACPI_VIDEO_DEVICE_POSTING		2
+#define ACPI_VIDEO_ROM_AVAILABLE		4
+#define ACPI_VIDEO_BRIGHTNESS			8
+#define ACPI_VIDEO_IGD				16
+#define ACPI_VIDEO_FORCE_VENDOR_SPECIFIC	32
+extern u8 acpi_video_support;
+
 #ifdef CONFIG_ACPI_EC
 
 extern int ec_read(u8 addr, u8 *val);


