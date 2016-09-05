From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 18/21] ACPI-video: Rename jump labels in
 acpi_video_init_brightness()
Date: Mon, 5 Sep 2016 19:05:14 +0200
Message-ID: <674c19a2-e7a9-436c-fd50-9d58f7832f14@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 17:28:45 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5f1ef6e..5566f68 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -888,11 +888,11 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	result = acpi_video_device_lcd_get_level_current(device,
 							 &level_old, true);
 	if (result)
-		goto out_free_levels;
+		goto free_levels;
 
 	result = acpi_video_bqc_quirk(device, max_level, level_old);
 	if (result)
-		goto out_free_levels;
+		goto free_levels;
 	/*
 	 * cap._BQC may get cleared due to _BQC is found to be broken
 	 * in acpi_video_bqc_quirk, so check again here.
@@ -912,17 +912,15 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 			break;
 	if (i == br->count || !level)
 		level = max_level;
-
-set_level:
+ set_level:
 	result = acpi_video_device_lcd_set_level(device, level);
 	if (result)
-		goto out_free_levels;
+		goto free_levels;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "found %d brightness levels\n", br->count - 2));
 	return 0;
-
-out_free_levels:
+ free_levels:
 	kfree(br->levels);
 	kfree(br);
 	device->brightness = NULL;
-- 
2.10.0

