From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI video: ignore BIOS initial backlight value for HP m4
Date: Tue, 28 May 2013 10:05:09 +0800
Message-ID: <1369706709-9189-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53555 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539Ab3E1CFV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2013 22:05:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org
Cc: Alex Hung <alex.hung@canonical.com>

On HP m4 lapops, BIOS reports minimum backlight on boot and
causes backlight to dim completely. This ignores the initial backlight
values and set to max brightness.

Buglink: https://bugs.launchpad.net/bugs/1184501

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5b32e15..d0937ab 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -464,6 +464,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
 		},
 	},
+	{
+	 .callback = video_ignore_initial_backlight,
+	 .ident = "HP Pavilion m4",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
+		},
+	},
 	{}
 };
 
-- 
1.8.1.2

