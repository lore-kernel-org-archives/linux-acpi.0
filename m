From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Add 4 new models to the use_native_backlight dmi list
Date: Thu,  1 May 2014 12:41:19 +0200
Message-ID: <1398940879-6455-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Acer Aspire V5-171
https://bugzilla.redhat.com/show_bug.cgi?id=983342

Acer Aspire V5-471G
Lenovo Yoga 2 11
Reported-and-tested-by: Vincent Gerris <vgerris@gmail.com>

HP EliteBook 8470p
https://bugzilla.redhat.com/show_bug.cgi?id=1093120

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8b6990e..48146fc 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -488,6 +488,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		},
 	},
 	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Lenovo Yoga 2 11",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga 2 11"),
+		},
+	},
+	{
 	.callback = video_set_use_native_backlight,
 	.ident = "Thinkpad Helix",
 	.matches = {
@@ -513,6 +521,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	 .callback = video_set_use_native_backlight,
+	 .ident = "Acer Aspire V5-171",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "V5-171"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
 	 .ident = "Acer Aspire V5-431",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
@@ -520,6 +536,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		},
 	},
 	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Acer Aspire V5-471G",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-471G"),
+		},
+	},
+	{
 	.callback = video_set_use_native_backlight,
 	.ident = "HP ProBook 4340s",
 	.matches = {
@@ -571,6 +595,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	.callback = video_set_use_native_backlight,
+	.ident = "HP EliteBook 8470p",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8470p"),
+		},
+	},
+	{
+	.callback = video_set_use_native_backlight,
 	.ident = "HP EliteBook 8780w",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-- 
1.9.0
