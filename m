From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] Untested proposal patch: Store video
	capabilities of BIOS	globally at ACPI parse time and export it.
Date: Mon, 15 Oct 2007 18:45:53 +0200
Message-ID: <1192466754.9847.594.camel@queen.suse.de>
Reply-To: trenn-l3A5Bk7waGM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ibm-acpi-devel <ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Store video capabilities of BIOS globally at ACPI parse time and export it.

This is for vendor specific vs video driver so that they can distinguish who
should take care of video/brightness control.
The bits are chosen in a way that video can handle the ability gracefully
if all the checked functions are there...

Vendor specific modules must check on that bits and take their hands off
brightness/video control when set, as they are then served by the video
driver.

This hasn't been tested yet. It's more a proposal whether this is the way
to go...
Would be great if someone could give it a test if accepted, I will test
this also as soon as some positive feedback is popping up.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

---
 drivers/acpi/scan.c  |   42 ++++++++++++++++++++++++++++++++++++------
 include/linux/acpi.h |    7 +++++++
 2 files changed, 43 insertions(+), 6 deletions(-)

Index: lenb/drivers/acpi/scan.c
===================================================================
--- lenb.orig/drivers/acpi/scan.c
+++ lenb/drivers/acpi/scan.c
@@ -870,6 +870,25 @@ static void acpi_device_get_busid(struct
 	}
 }
 
+u8 acpi_video_support;
+EXPORT_SYMBOL(acpi_video_support);
+
+static acpi_status
+acpi_brighntess_cap_match(acpi_handle handle, u32 level, void *context,
+			  void **return_value)
+{
+	acpi_handle h_dummy1;
+	acpi_handle h_dummy2;
+	acpi_handle h_dummy3;
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy1)) &&
+	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy2)) &&
+	    ACPI_SUCCESS(acpi_get_handle(handle, "_BQC", &h_dummy3)))
+		acpi_video_support |= ACPI_VIDEO_BRIGHTNESS;
+
+	return 0;
+}
+
 static int
 acpi_video_bus_match(struct acpi_device *device)
 {
@@ -887,20 +906,31 @@ acpi_video_bus_match(struct acpi_device 
 
 	/* Does this device able to support video switching ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy2)))
-		return 0;
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy2))) {
+		acpi_video_support |= ACPI_VIDEO_OUTPUT_SWITCHING;
+		goto success;
+	}
 
 	/* Does this device able to retrieve a video ROM ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy1)))
-		return 0;
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy1))) {
+		acpi_video_support |= ACPI_VIDEO_ROM_AVAILABLE;
+		goto success;
+	}
 
 	/* Does this device able to configure which video head to be POSTed ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy1)) &&
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy2)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy3)))
-		return 0;
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy3))) {
+		acpi_video_support |= ACPI_VIDEO_DEVICE_POSTING;
+		goto success;
+	}
 
 	return -ENODEV;
+
+ success:
+	acpi_walk_namespace(ACPI_TYPE_METHOD, device->handle, ACPI_UINT32_MAX,
+			    acpi_brighntess_cap_match, NULL, NULL);
+	return 0;
 }
 
 /*
Index: lenb/include/linux/acpi.h
===================================================================
--- lenb.orig/include/linux/acpi.h
+++ lenb/include/linux/acpi.h
@@ -184,6 +184,13 @@ struct acpi_pci_driver {
 int acpi_pci_register_driver(struct acpi_pci_driver *driver);
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
 
+/* video/brightness support */
+#define ACPI_VIDEO_OUTPUT_SWITCHING	1
+#define ACPI_VIDEO_DEVICE_POSTING	2
+#define ACPI_VIDEO_ROM_AVAILABLE	4
+#define ACPI_VIDEO_BRIGHTNESS		8
+extern u8 acpi_video_support;
+
 #endif /* CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_EC



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
