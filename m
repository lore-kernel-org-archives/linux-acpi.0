From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 14/16] memory leakages in driver/acpi/video.c
Date: Mon, 15 May 2006 02:15:04 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F4FE@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63510 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932235AbWEOGPL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2006 02:15:11 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>, vvs@sw.ru

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; Yu, Luming; vvs@sw.ru
>Subject: [patch 14/16] memory leakages in driver/acpi/video.c
>
>
>From: "Yu, Luming" <luming.yu@intel.com>
>
>acpi_video_bus_get_one_device() and other functions in 
>driver/acpi/video.c do
>not release allocated memory on remove and on the error path.
>
>Signed-off-by: "Yu, Luming" <luming.yu@intel.com>
>Signed-off-by: Vasily Averin <vvs@sw.ru>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/video.c |   21 +++++++++++++--------
> 1 files changed, 13 insertions(+), 8 deletions(-)
>
>diff -puN 
>drivers/acpi/video.c~fw-memory-leakages-in-driver-acpi-videoc 
>drivers/acpi/video.c
>--- 
>devel/drivers/acpi/video.c~fw-memory-leakages-in-driver-acpi
>-videoc	2006-04-18 22:28:22.000000000 -0700
>+++ devel-akpm/drivers/acpi/video.c	2006-04-18 
>22:28:22.000000000 -0700
>@@ -1284,7 +1284,7 @@ acpi_video_bus_get_one_device(struct acp
> 			      struct acpi_video_bus *video)
> {
> 	unsigned long device_id;
>-	int status, result;
>+	int status;
> 	struct acpi_video_device *data;
> 
> 	ACPI_FUNCTION_TRACE("acpi_video_bus_get_one_device");
>@@ -1334,8 +1334,11 @@ acpi_video_bus_get_one_device(struct acp
> 						     
>acpi_video_device_notify,
> 						     data);
> 		if (ACPI_FAILURE(status)) {
>-			result = -ENODEV;
>-			goto end;
>+			if(data->brightness)
>+				kfree(data->brightness->levels);
>+			kfree(data->brightness);
>+			kfree(data);
>+			return_VALUE(-ENODEV);
> 		}
> 
> 		down(&video->sem);
>@@ -1347,7 +1350,6 @@ acpi_video_bus_get_one_device(struct acp
> 		return_VALUE(0);
> 	}
> 
>-      end:
> 	return_VALUE(-ENOENT);
> }
> 
>@@ -1626,8 +1628,9 @@ static int acpi_video_bus_put_devices(st
> 			printk(KERN_WARNING PREFIX
> 			       "hhuuhhuu bug in acpi video driver.\n");
> 
>+		if (data->brightness);
>+			kfree(data->brightness->levels);
> 		kfree(data->brightness);
>-
> 		kfree(data);
> 	}
> 
>@@ -1766,6 +1769,10 @@ static int acpi_video_bus_add(struct acp
> 					     ACPI_DEVICE_NOTIFY,
> 					     
>acpi_video_bus_notify, video);
> 	if (ACPI_FAILURE(status)) {
>+		acpi_video_bus_stop_devices(video);
>+		acpi_video_bus_put_devices(video);
>+		kfree(video->attached_array);
>+		acpi_video_bus_remove_fs(device);
> 		result = -ENODEV;
> 		goto end;
> 	}
>@@ -1777,10 +1784,8 @@ static int acpi_video_bus_add(struct acp
> 	       video->flags.post ? "yes" : "no");
> 
>       end:
>-	if (result) {
>-		acpi_video_bus_remove_fs(device);
>+	if (result)
> 		kfree(video);
>-	}
> 
> 	return_VALUE(result);
> }
>_
>
