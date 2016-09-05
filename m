From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 11/21] ACPI-video: Rename jump labels in
 acpi_video_bus_add_notify_handler()
Date: Mon, 5 Sep 2016 18:58:03 +0200
Message-ID: <5042c0fb-2102-2feb-9844-8f5a0e027914@users.sourceforge.net>
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
Date: Mon, 5 Sep 2016 15:50:12 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 6c871dd..fe9b40e 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1857,7 +1857,7 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
 
 	error = acpi_video_bus_start_devices(video);
 	if (error)
-		goto err_free_input;
+		goto free_device;
 
 	snprintf(video->phys, sizeof(video->phys),
 			"%s/video/input0", acpi_device_hid(video->device));
@@ -1879,7 +1879,7 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
 
 	error = input_register_device(input);
 	if (error)
-		goto err_stop_dev;
+		goto stop_devices;
 
 	mutex_lock(&video->device_list_lock);
 	list_for_each_entry(dev, &video->video_device_list, entry)
@@ -1887,10 +1887,9 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
 	mutex_unlock(&video->device_list_lock);
 
 	return 0;
-
-err_stop_dev:
+ stop_devices:
 	acpi_video_bus_stop_devices(video);
-err_free_input:
+ free_device:
 	input_free_device(input);
 	video->input = NULL;
 	return error;
-- 
2.10.0
