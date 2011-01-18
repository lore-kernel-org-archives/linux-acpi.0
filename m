From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH 2/2] ACPI video: add initial blacklist to use vendor drivers for backlight
Date: Tue, 18 Jan 2011 16:41:54 -0200
Message-ID: <1295376114-5685-2-git-send-email-herton@mandriva.com.br>
References: <1295376114-5685-1-git-send-email-herton@mandriva.com.br>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1295376114-5685-1-git-send-email-herton@mandriva.com.br>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: linux-acpi@vger.kernel.org

While developing shuttle-wmi, I discovered some shuttle machines where
its acpi video interface doesn't work properly. Changes to the
brightness value don't reflect actual hardware changes. For these
devices, a quirk is done in shuttle-wmi driver, where brightness values
are then changed properly in the hardware too.

This adds a list for shuttle devices I tested which doesn't have working
backlight support in acpi video, but works with workaround done in
shuttle-wmi driver, so for them, add dmi blacklist to use vendor driver.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 drivers/acpi/video_detect.c |   56 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b836761..39814d2 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -132,6 +132,45 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
+static struct dmi_system_id backlight_vendor_dmi_table[] = {
+	{
+		.ident = "Positivo M13",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "POSITIVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "M13"),
+		},
+	},
+	{
+		.ident = "Positivo M14",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "POSITIVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "M14"),
+		},
+	},
+	{
+		.ident = "Positivo A14IM01",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "POSITIVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "A14IM01"),
+		},
+	},
+	{
+		.ident = "Positivo J14IM21",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "POSITIVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "J14IM21"),
+		},
+	},
+	{
+		.ident = "Positivo SINM10BZ",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Positivo Informatica SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "POS-SINM10BZ"),
+		},
+	},
+	{}
+};
+
 /*
  * Returns the video capabilities of a specific ACPI graphics device
  *
@@ -156,16 +195,13 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 		/* There might be boot param flags set already... */
 		acpi_video_support |= caps;
 		acpi_video_caps_checked = 1;
-		/* Add blacklists here. Be careful to use the right *DMI* bits
-		 * to still be able to override logic via boot params, e.g.:
-		 *
-		 *   if (dmi_name_in_vendors("XY")) {
-		 *	acpi_video_support |=
-		 *		ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR;
-		 *	acpi_video_support |=
-		 *		ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
-		 *}
-		 */
+		/* Add blacklists here (systems which don't work properly with
+		 * acpi video and needs a special platform driver) */
+		if (dmi_check_system(backlight_vendor_dmi_table))
+			acpi_video_support |= ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
+		/*if (dmi_check_system(output_switching_vendor_dmi_table))
+			acpi_video_support |=
+				ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR;*/
 	} else {
 		status = acpi_bus_get_device(graphics_handle, &tmp_dev);
 		if (ACPI_FAILURE(status)) {
-- 
1.7.3.5
