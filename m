From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] acpi-video: Disable native_backlight on HP ENVY 15 Notebook PC
Date: Thu, 28 Aug 2014 10:20:47 +0200
Message-ID: <1409214048-7331-3-git-send-email-hdegoede@redhat.com>
References: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934221AbaH1IVH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Aug 2014 04:21:07 -0400
In-Reply-To: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, =?UTF-8?q?Andre=20M=C3=BCller?= <andre.muller@web.de>, Hohahiu <rakothedin@gmail.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org.#.3.16

https://bugs.freedesktop.org/show_bug.cgi?id=81515

Reported-and-tested-by: Hohahiu <rakothedin@gmail.com>
Cc: stable@vger.kernel.org # 3.16
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index dd5c302..fcbda10 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -750,6 +750,17 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T520"),
 		},
 	},
+
+	/* The native backlight controls do not work on some older machines */
+	{
+	 /* https://bugs.freedesktop.org/show_bug.cgi?id=81515 */
+	 .callback = video_disable_native_backlight,
+	 .ident = "HP ENVY 15 Notebook",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP ENVY 15 Notebook PC"),
+		},
+	},
 	{}
 };
 
-- 
2.1.0

