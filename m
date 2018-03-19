From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / video: Add a quirk to force acpi-video backlight on Samsung 670Z5E
Date: Mon, 19 Mar 2018 18:01:45 +0100
Message-ID: <20180319170145.21371-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Just like many other Samsung models, the 670Z5E needs to use the acpi-video
backlight interface rather then the native one for backlight control to
work, add a quirk for this.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1557060
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 601e5d372887..43587ac680e4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -219,6 +219,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 			  "3570R/370R/470R/450R/510R/4450RV"),
 		},
 	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1557060 */
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 670Z5E",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "670Z5E"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
 	 .callback = video_detect_force_video,
-- 
2.14.3
