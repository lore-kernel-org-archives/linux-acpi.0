From: tianyu.lan@intel.com
Subject: [Fix PATCH] ACPI / video: ignore BIOS initial backlight value for Fujitsu E753
Date: Tue, 16 Jul 2013 10:07:21 +0800
Message-ID: <1373940441-21875-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2469 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434Ab3GPCPQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 22:15:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

The BIOS of FUjitsu E753 reports an incorrect initial backlight value
for WIN8 compatible OS, causing backlight dark during startup. This
patch ignores the incorrect initial value from BIOS.

Reference:https://bugzilla.kernel.org/show_bug.cgi?id=60161
Reported-and-tested-by: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/video.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5d7075d..e441876 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -450,6 +450,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	 .callback = video_ignore_initial_backlight,
+	 .ident = "Fujitsu E753",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "FUJITSU"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E753"),
+		},
+	},
+	{
+	 .callback = video_ignore_initial_backlight,
 	 .ident = "HP Pavilion dm4",
 	 .matches = {
 		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-- 
1.7.9.5

