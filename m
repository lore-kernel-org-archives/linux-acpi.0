From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Add disable_native_backlight quirk for Samsung 510R
Date: Sat,  7 Feb 2015 09:53:53 +0100
Message-ID: <1423299233-11862-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: stable@vger.kernel.org, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Backlight control through the native intel interface does not work properly
on the Samsung 510R, where as using the acpi_video interface does work, add
a quirk for this.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1186097
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 497d986..88a4f99 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -523,6 +523,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		},
 	},
 	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1186097 */
+	 .callback = video_disable_native_backlight,
+	 .ident = "SAMSUNG 3570R/370R/470R/450R/510R/4450RV",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "3570R/370R/470R/450R/510R/4450RV"),
+		},
+	},
+	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
 	 .callback = video_disable_native_backlight,
 	 .ident = "SAMSUNG 730U3E/740U3E",
-- 
2.2.2
