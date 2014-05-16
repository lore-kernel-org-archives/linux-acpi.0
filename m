From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Revert native brightness quirk for ThinkPad T530
Date: Fri, 16 May 2014 21:10:41 +0200
Message-ID: <1400267441-6267-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Seems it helps some users, but causes issues for other users:
https://bugzilla.redhat.com/show_bug.cgi?id=1089545

So lets drop it for now until we've figured out a better fix.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 0fec70d..8309100 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -516,14 +516,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad T530",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T530"),
-		},
-	},
-	{
-	 .callback = video_set_use_native_backlight,
 	 .ident = "ThinkPad W530",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-- 
1.9.0
