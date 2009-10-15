From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH 8/8] trivial: typo and grammar fixes in comments
Date: Thu, 15 Oct 2009 17:18:39 -0300
Message-ID: <1255637919-6178-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763023AbZJOUT1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/acpi/video_detect.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 575593a..27c7772 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -7,7 +7,7 @@
  * video_detect.c:
  * Provides acpi_is_video_device() for early scanning of ACPI devices in scan.c
  * There a Linux specific (Spec does not provide a HID for video devices) is
- * assinged
+ * assigned
  *
  * After PCI devices are glued with ACPI devices
  * acpi_get_pci_dev() can be called to identify ACPI graphics
@@ -83,16 +83,16 @@ long acpi_is_video_device(struct acpi_device *device)
 	if (!device)
 		return 0;
 
-	/* Does this device able to support video switching ? */
+	/* Is this device able to support video switching ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) ||
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
 		video_caps |= ACPI_VIDEO_OUTPUT_SWITCHING;
 
-	/* Does this device able to retrieve a video ROM ? */
+	/* Is this device able to retrieve a video ROM ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy)))
 		video_caps |= ACPI_VIDEO_ROM_AVAILABLE;
 
-	/* Does this device able to configure which video head to be POSTed ? */
+	/* Is this device able to configure which video head to be POSTed ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy)) &&
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy)) &&
 	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy)))
@@ -137,7 +137,7 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
  *
  * if NULL is passed as argument all ACPI devices are enumerated and
  * all graphics capabilities of physically present devices are
- * summerized and returned. This is cached and done only once.
+ * summarized and returned. This is cached and done only once.
  */
 long acpi_video_get_capabilities(acpi_handle graphics_handle)
 {
-- 
1.6.3.3
