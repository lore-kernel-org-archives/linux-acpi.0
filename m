From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI video: ignore BIOS initial backlight value for HP 1000
Date: Mon,  6 May 2013 16:23:43 +0800
Message-ID: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60753 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab3EFIXy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2013 04:23:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alex.hung@canonical.com, rui.zhang@intel.com, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On HP 1000 lapops, BIOS reports minimum backlight on boot and
causes backlight to dim completely. This ignores the initial backlight
values and set to max brightness.

Buglink: https://bugs.launchpad.net/bugs/1167760

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/video.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index c3932d0..5b32e15 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -456,6 +456,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dm4 Notebook PC"),
 		},
 	},
+	{
+	 .callback = video_ignore_initial_backlight,
+	 .ident = "HP 1000 Notebook PC",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
+		},
+	},
 	{}
 };
 
-- 
1.7.9.5

