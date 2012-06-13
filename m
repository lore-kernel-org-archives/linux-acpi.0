From: Corentin Chary <corentin.chary@gmail.com>
Subject: [PATCH 4/7] acpi/video_detect: blacklist samsung x360
Date: Wed, 13 Jun 2012 09:32:04 +0200
Message-ID: <1339572727-24744-5-git-send-email-corentin.chary@gmail.com>
References: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Samsung X360, the BIOS will set a flag (VDRV) if the generic
ACPI backlight device is used. This flag will definitively break
the backlight interface (even the vendor interface) untill next
reboot. It's why we should prevent video.ko from being used here
and we can't rely on a later call to acpi_video_unregister().

Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
---
 drivers/acpi/video_detect.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 942fa2a..b728880 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -132,6 +132,33 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
+/* Force to use vendor driver when the ACPI device is known to be
+ * buggy */
+static int video_detect_force_vendor(const struct dmi_system_id *d)
+{
+	acpi_video_support |= ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
+	return 0;
+}
+
+static struct dmi_system_id video_detect_dmi_table[] = {
+	/* On Samsung X360, the BIOS will set a flag (VDRV) if generic
+	 * ACPI backlight device is used. This flag will definitively break
+	 * the backlight interface (even the vendor interface) untill next
+	 * reboot. It's why we should prevent video.ko from being used here
+	 * and we can't rely on a later call to acpi_video_unregister().
+	 */
+	{
+	 .callback = video_detect_force_vendor,
+	 .ident = "X360",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X360"),
+		DMI_MATCH(DMI_BOARD_NAME, "X360"),
+		},
+	},
+	{ },
+};
+
 /*
  * Returns the video capabilities of a specific ACPI graphics device
  *
@@ -164,6 +191,8 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 		 *		ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
 		 *}
 		 */
+
+		dmi_check_system(video_detect_dmi_table);
 	} else {
 		status = acpi_bus_get_device(graphics_handle, &tmp_dev);
 		if (ACPI_FAILURE(status)) {
-- 
1.7.9.5
