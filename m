From: akpm@osdl.org
Subject: [patch 14/16] memory leakages in driver/acpi/video.c
Date: Thu, 27 Apr 2006 02:25:14 -0700
Message-ID: <200604270926.k3R9Qgh7025111@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:55757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965020AbWD0J1U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 05:27:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, luming.yu@intel.com, vvs@sw.ru


From: "Yu, Luming" <luming.yu@intel.com>

acpi_video_bus_get_one_device() and other functions in driver/acpi/video.c do
not release allocated memory on remove and on the error path.

Signed-off-by: "Yu, Luming" <luming.yu@intel.com>
Signed-off-by: Vasily Averin <vvs@sw.ru>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/video.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff -puN drivers/acpi/video.c~fw-memory-leakages-in-driver-acpi-videoc drivers/acpi/video.c
--- devel/drivers/acpi/video.c~fw-memory-leakages-in-driver-acpi-videoc	2006-04-18 22:28:22.000000000 -0700
+++ devel-akpm/drivers/acpi/video.c	2006-04-18 22:28:22.000000000 -0700
@@ -1284,7 +1284,7 @@ acpi_video_bus_get_one_device(struct acp
 			      struct acpi_video_bus *video)
 {
 	unsigned long device_id;
-	int status, result;
+	int status;
 	struct acpi_video_device *data;
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_get_one_device");
@@ -1334,8 +1334,11 @@ acpi_video_bus_get_one_device(struct acp
 						     acpi_video_device_notify,
 						     data);
 		if (ACPI_FAILURE(status)) {
-			result = -ENODEV;
-			goto end;
+			if(data->brightness)
+				kfree(data->brightness->levels);
+			kfree(data->brightness);
+			kfree(data);
+			return_VALUE(-ENODEV);
 		}
 
 		down(&video->sem);
@@ -1347,7 +1350,6 @@ acpi_video_bus_get_one_device(struct acp
 		return_VALUE(0);
 	}
 
-      end:
 	return_VALUE(-ENOENT);
 }
 
@@ -1626,8 +1628,9 @@ static int acpi_video_bus_put_devices(st
 			printk(KERN_WARNING PREFIX
 			       "hhuuhhuu bug in acpi video driver.\n");
 
+		if (data->brightness);
+			kfree(data->brightness->levels);
 		kfree(data->brightness);
-
 		kfree(data);
 	}
 
@@ -1766,6 +1769,10 @@ static int acpi_video_bus_add(struct acp
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_video_bus_notify, video);
 	if (ACPI_FAILURE(status)) {
+		acpi_video_bus_stop_devices(video);
+		acpi_video_bus_put_devices(video);
+		kfree(video->attached_array);
+		acpi_video_bus_remove_fs(device);
 		result = -ENODEV;
 		goto end;
 	}
@@ -1777,10 +1784,8 @@ static int acpi_video_bus_add(struct acp
 	       video->flags.post ? "yes" : "no");
 
       end:
-	if (result) {
-		acpi_video_bus_remove_fs(device);
+	if (result)
 		kfree(video);
-	}
 
 	return_VALUE(result);
 }
_
