From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 12/21] ACPI-video: Delete unnecessary if statement in
 acpi_video_switch_brightness()
Date: Mon, 5 Sep 2016 18:59:07 +0200
Message-ID: <e2b752b3-512f-5e07-b325-a34b301a4685@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:60700 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965678AbcIEQ7Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 12:59:24 -0400
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 16:10:40 +0200

Move a function call into an else branch for successful function execution.
Omit a duplicate check for the local variable "result" then at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index fe9b40e..0362a43 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1372,14 +1372,12 @@ acpi_video_switch_brightness(struct work_struct *work)
 	level_next = acpi_video_get_next_level(device, level_current, event);
 
 	result = acpi_video_device_lcd_set_level(device, level_next);
-
-	if (!result)
-		backlight_force_update(device->backlight,
-				       BACKLIGHT_UPDATE_HOTKEY);
-
 out:
 	if (result)
 		printk(KERN_ERR PREFIX "Failed to switch the brightness\n");
+	else
+		backlight_force_update(device->backlight,
+				       BACKLIGHT_UPDATE_HOTKEY);
 }
 
 int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
-- 
2.10.0

