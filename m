From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Add use native backlight quirk for the ThinkPad W530
Date: Mon, 12 May 2014 09:57:12 +0200
Message-ID: <1399881432-26124-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Like all of the other *30 ThinkPad models, the W530 has a broken acpi-video
backlight control. Note in order for this to actually fix things on the
ThinkPad W530 the commit titled:
"nouveau: Don't check acpi_video_backlight_support() before registering backlight"
is also needed.

https://bugzilla.redhat.com/show_bug.cgi?id=1093171

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 34198b2..6a2099d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -520,6 +520,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		},
 	},
 	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad W530",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
+		},
+	},
+	{
 	.callback = video_set_use_native_backlight,
 	.ident = "ThinkPad X1 Carbon",
 	.matches = {
-- 
1.9.0
