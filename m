From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 5/9] ACPI-video: Delete unnecessary if statement in
 acpi_video_switch_brightness()
Date: Wed, 9 Aug 2017 17:41:32 +0200
Message-ID: <73ab1d2b-74bf-5376-e45a-8d04d3b32406@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
 <CAJZ5v0hug9QfZHQosCFFXEcFMsDd=YvXkqMmQya3RSqmOnY4dg@mail.gmail.com>
 <3e0cdc5b-fd15-515a-82f2-2f44792664ed@users.sourceforge.net>
 <CAJZ5v0gWgxbtJ4m0eDkdOaR_usjTqmcWBWds5qprr+ydHhEjnA@mail.gmail.com>
 <6882cbb1-3f61-fb64-2972-30c277f28580@users.sourceforge.net>
 <CAJZ5v0hyhdUknW8RqpT6f4zAuPuMN1EN=P7C54Aa+VqEK2pcGw@mail.gmail.com>
 <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:53300 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdHIPll (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Aug 2017 11:41:41 -0400
In-Reply-To: <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 15:43:17 +0200

Move a function call into an else branch for successful function execution.
Omit a duplicate check for the local variable "result" then at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 09ea1f115f55..8295ae1deab9 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1422,14 +1422,12 @@ acpi_video_switch_brightness(struct work_struct *work)
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
2.13.4

