From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] acpi-video: Add use_native_backlight quirks for ThinkPad T430, T530 and Acer Aspire 5742G
Date: Mon,  5 May 2014 11:38:08 +0200
Message-ID: <1399282690-5381-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571AbaEEJiW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 May 2014 05:38:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, edm <fuffi.il.fuffo@gmail.com>, Balint Szigeti <balint.szgt@gmail.com>, AnAkkk <anakin.cs@gmail.com>, lou.cardone@gmail.com, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org

ThinkPad T430: extend the T430s entry to also cover the T430 (note we also
have another entry for T430's with a different DMI_PRODUCT_VERSION).

Reported-and-tested-by: edm <fuffi.il.fuffo@gmail.com>
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=51231

Thinkpad T530
Reported-and-tested-by: Balint Szigeti <balint.szgt@gmail.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1089545

Acer Aspire 5742G
Reported-and-tested-by: AnAkkk <anakin.cs@gmail.com>
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=35622

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index e7a1190..cebc74d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -473,10 +473,10 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad T430s",
+	 .ident = "ThinkPad T430 and T430s",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430"),
 		},
 	},
 	{
@@ -512,6 +512,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		},
 	},
 	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad T530",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T530"),
+		},
+	},
+	{
 	.callback = video_set_use_native_backlight,
 	.ident = "ThinkPad X1 Carbon",
 	.matches = {
@@ -561,6 +569,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	 .callback = video_set_use_native_backlight,
+	 .ident = "Acer Aspire 5742G",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5742G"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
 	 .ident = "Acer Aspire V5-171",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
1.9.0

