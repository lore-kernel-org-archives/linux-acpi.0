From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 04/32] acpi-video-detect: Move acpi_is_video_device() to acpi/scan.c
Date: Wed, 10 Jun 2015 15:01:04 +0200
Message-ID: <1433941292-21530-5-git-send-email-hdegoede@redhat.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

This allows video_detect.c to be build as a module, this is a preparation
patch for the backlight interface selection logic cleanup.

Note this commit also causes acpi_is_video_device() to always be build
indepedent of CONFIG_ACPI_VIDEO, as there is no reason to make its
building depend on CONFIG_ACPI_VIDEO.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c         | 56 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/video_detect.c | 60 ---------------------------------------------
 include/linux/acpi.h        |  8 ++----
 3 files changed, 58 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 03141aa..811b40d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1947,6 +1947,62 @@ bool acpi_dock_match(acpi_handle handle)
 	return acpi_has_method(handle, "_DCK");
 }
 
+static acpi_status
+acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
+			  void **return_value)
+{
+	long *cap = context;
+
+	if (acpi_has_method(handle, "_BCM") &&
+	    acpi_has_method(handle, "_BCL")) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
+				  "support\n"));
+		*cap |= ACPI_VIDEO_BACKLIGHT;
+		if (!acpi_has_method(handle, "_BQC"))
+			printk(KERN_WARNING FW_BUG PREFIX "No _BQC method, "
+				"cannot determine initial brightness\n");
+		/* We have backlight support, no need to scan further */
+		return AE_CTRL_TERMINATE;
+	}
+	return 0;
+}
+
+/* Returns true if the ACPI object is a video device which can be
+ * handled by video.ko.
+ * The device will get a Linux specific CID added in scan.c to
+ * identify the device as an ACPI graphics device
+ * Be aware that the graphics device may not be physically present
+ * Use acpi_video_get_capabilities() to detect general ACPI video
+ * capabilities of present cards
+ */
+long acpi_is_video_device(acpi_handle handle)
+{
+	long video_caps = 0;
+
+	/* Is this device able to support video switching ? */
+	if (acpi_has_method(handle, "_DOD") || acpi_has_method(handle, "_DOS"))
+		video_caps |= ACPI_VIDEO_OUTPUT_SWITCHING;
+
+	/* Is this device able to retrieve a video ROM ? */
+	if (acpi_has_method(handle, "_ROM"))
+		video_caps |= ACPI_VIDEO_ROM_AVAILABLE;
+
+	/* Is this device able to configure which video head to be POSTed ? */
+	if (acpi_has_method(handle, "_VPO") &&
+	    acpi_has_method(handle, "_GPD") &&
+	    acpi_has_method(handle, "_SPD"))
+		video_caps |= ACPI_VIDEO_DEVICE_POSTING;
+
+	/* Only check for backlight functionality if one of the above hit. */
+	if (video_caps)
+		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
+				    ACPI_UINT32_MAX, acpi_backlight_cap_match, NULL,
+				    &video_caps, NULL);
+
+	return video_caps;
+}
+EXPORT_SYMBOL(acpi_is_video_device);
+
 const char *acpi_device_hid(struct acpi_device *device)
 {
 	struct acpi_hardware_id *hid;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 68c45c3..aad5cf4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -5,10 +5,6 @@
  *  May be copied or modified under the terms of the GNU General Public License
  *
  * video_detect.c:
- * Provides acpi_is_video_device() for early scanning of ACPI devices in scan.c
- * There a Linux specific (Spec does not provide a HID for video devices) is
- * assigned
- *
  * After PCI devices are glued with ACPI devices
  * acpi_get_pci_dev() can be called to identify ACPI graphics
  * devices for which a real graphics card is plugged in
@@ -47,62 +43,6 @@ static long acpi_video_support;
 static bool acpi_video_caps_checked;
 
 static acpi_status
-acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
-			  void **return_value)
-{
-	long *cap = context;
-
-	if (acpi_has_method(handle, "_BCM") &&
-	    acpi_has_method(handle, "_BCL")) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
-				  "support\n"));
-		*cap |= ACPI_VIDEO_BACKLIGHT;
-		if (!acpi_has_method(handle, "_BQC"))
-			printk(KERN_WARNING FW_BUG PREFIX "No _BQC method, "
-				"cannot determine initial brightness\n");
-		/* We have backlight support, no need to scan further */
-		return AE_CTRL_TERMINATE;
-	}
-	return 0;
-}
-
-/* Returns true if the ACPI object is a video device which can be
- * handled by video.ko.
- * The device will get a Linux specific CID added in scan.c to
- * identify the device as an ACPI graphics device
- * Be aware that the graphics device may not be physically present
- * Use acpi_video_get_capabilities() to detect general ACPI video
- * capabilities of present cards
- */
-long acpi_is_video_device(acpi_handle handle)
-{
-	long video_caps = 0;
-
-	/* Is this device able to support video switching ? */
-	if (acpi_has_method(handle, "_DOD") || acpi_has_method(handle, "_DOS"))
-		video_caps |= ACPI_VIDEO_OUTPUT_SWITCHING;
-
-	/* Is this device able to retrieve a video ROM ? */
-	if (acpi_has_method(handle, "_ROM"))
-		video_caps |= ACPI_VIDEO_ROM_AVAILABLE;
-
-	/* Is this device able to configure which video head to be POSTed ? */
-	if (acpi_has_method(handle, "_VPO") &&
-	    acpi_has_method(handle, "_GPD") &&
-	    acpi_has_method(handle, "_SPD"))
-		video_caps |= ACPI_VIDEO_DEVICE_POSTING;
-
-	/* Only check for backlight functionality if one of the above hit. */
-	if (video_caps)
-		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-				    ACPI_UINT32_MAX, acpi_backlight_cap_match, NULL,
-				    &video_caps, NULL);
-
-	return video_caps;
-}
-EXPORT_SYMBOL(acpi_is_video_device);
-
-static acpi_status
 find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	long *cap = context;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 88c92a03..7cb3b0b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -243,19 +243,15 @@ extern bool wmi_has_guid(const char *guid);
 #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR		0x0400
 #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO		0x0800
 
+extern long acpi_is_video_device(acpi_handle handle);
+
 #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
 
-extern long acpi_is_video_device(acpi_handle handle);
 extern void acpi_video_dmi_promote_vendor(void);
 extern int acpi_video_backlight_support(void);
 
 #else
 
-static inline long acpi_is_video_device(acpi_handle handle)
-{
-	return 0;
-}
-
 static inline void acpi_video_dmi_promote_vendor(void)
 {
 }
-- 
2.4.2
