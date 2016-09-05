From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 13/21] ACPI-video: Improve a jump target in
 acpi_video_switch_brightness()
Date: Mon, 5 Sep 2016 19:00:06 +0200
Message-ID: <786e4156-5316-1313-7ac1-45e646be2776@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:59597 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965322AbcIERA3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 13:00:29 -0400
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 16:34:08 +0200

* Avoid another duplicate check for the local variable "result"
  then at the end.

* Jump directly to an error message in the case that the desired brightness
  can not be switched.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0362a43..fe10d3f 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1361,19 +1361,19 @@ acpi_video_switch_brightness(struct work_struct *work)
 		return;
 
 	if (!device->brightness)
-		goto out;
+		goto report_failure;
 
 	result = acpi_video_device_lcd_get_level_current(device,
 							 &level_current,
 							 false);
 	if (result)
-		goto out;
+		goto report_failure;
 
 	level_next = acpi_video_get_next_level(device, level_current, event);
 
 	result = acpi_video_device_lcd_set_level(device, level_next);
-out:
 	if (result)
+ report_failure:
 		printk(KERN_ERR PREFIX "Failed to switch the brightness\n");
 	else
 		backlight_force_update(device->backlight,
-- 
2.10.0

