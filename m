From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 6/9] ACPI-video: Improve a jump target in
 acpi_video_switch_brightness()
Date: Wed, 9 Aug 2017 17:42:49 +0200
Message-ID: <dd6a897c-0dd1-f49c-b3c9-eb995ec48a7f@users.sourceforge.net>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 15:45:35 +0200

* Avoid another duplicate check for the local variable "result"
  then at the end.

* Jump directly to an error message in the case that the desired brightness
  can not be switched.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 8295ae1deab9..e279ed221961 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1411,19 +1411,19 @@ acpi_video_switch_brightness(struct work_struct *work)
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
2.13.4
