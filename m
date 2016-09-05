From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 07/21] ACPI-video: Rename jump labels in acpi_video_bus_add()
Date: Mon, 5 Sep 2016 18:53:41 +0200
Message-ID: <56f7a0f4-3e78-b92f-8d71-2c592740d70e@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 15:01:23 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0fca196..8003c90 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1983,14 +1983,14 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	acpi_video_bus_find_cap(video);
 	error = acpi_video_bus_check(video);
 	if (error)
-		goto err_free_video;
+		goto free_video;
 
 	mutex_init(&video->device_list_lock);
 	INIT_LIST_HEAD(&video->video_device_list);
 
 	error = acpi_video_bus_get_devices(video, device);
 	if (error)
-		goto err_put_video;
+		goto put_devices;
 
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
@@ -2005,11 +2005,10 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	acpi_video_bus_add_notify_handler(video);
 
 	return 0;
-
-err_put_video:
+ put_devices:
 	acpi_video_bus_put_devices(video);
 	kfree(video->attached_array);
-err_free_video:
+ free_video:
 	kfree(video);
 	device->driver_data = NULL;
 
-- 
2.10.0
