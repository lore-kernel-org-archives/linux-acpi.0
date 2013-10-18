From: Kirill Tkhai <tkhai@yandex.ru>
Subject: [PATCH] ACPI: video: Ignore BIOS initial backlight value for HP 250 G1
Date: Fri, 18 Oct 2013 15:56:44 +0400
Message-ID: <100851382097404@web21g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward16.mail.yandex.net ([95.108.253.141]:52547 "EHLO
	forward16.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab3JRL4r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2013 07:56:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net

On HP 250 G1 laptops, BIOS reports minimum backlight on boot and
causes backlight to dim completely. This ignores the initial backlight
values and set to max brightness.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=63111
Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
---
 drivers/acpi/video.c | 8 ++++++++
 1 file changed, 8 insertions(+)
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 3270d3c..6456466 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -490,6 +490,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
 		},
 	},
+	{
+	 .callback = video_ignore_initial_backlight,
+	 .ident = "HP 250 G1",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G1 Notebook PC"),
+		},
+	},
 	{}
 };
 
