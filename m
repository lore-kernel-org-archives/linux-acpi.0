From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Add video.use_native_backlight=1 for HP EliteBook 2014 models
Date: Mon, 28 Jul 2014 17:37:33 +0200
Message-ID: <1406561853-30723-2-git-send-email-hdegoede@redhat.com>
References: <1406561853-30723-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbaG1Phk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jul 2014 11:37:40 -0400
In-Reply-To: <1406561853-30723-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org

https://bugzilla.redhat.com/show_bug.cgi?id=1123565

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 18c0e69..8268843 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -673,6 +673,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	.callback = video_set_use_native_backlight,
+	.ident = "HP EliteBook 2014 models",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
+		DMI_MATCH(DMI_PRODUCT_NAME, " G2"),
+		},
+	},
+	{
+	.callback = video_set_use_native_backlight,
 	.ident = "HP ZBook 14",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-- 
2.0.1

