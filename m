From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Put the Acer Aspire V5-471G on the use_native_backlight dmi list
Date: Wed, 30 Apr 2014 15:37:21 +0200
Message-ID: <1398865041-12071-2-git-send-email-hdegoede@redhat.com>
References: <1398865041-12071-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38938 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758947AbaD3Nhc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2014 09:37:32 -0400
In-Reply-To: <1398865041-12071-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org

This fixes the backlight control not working.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Vincent Gerris <vgerris@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8b6990e..c688b77 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -520,6 +520,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
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
-- 
1.9.0

