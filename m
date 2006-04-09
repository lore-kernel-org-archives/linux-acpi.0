From: Vasily Averin <vvs@sw.ru>
Subject: [PATCH ACPI] memory leakages in driver/acpi/video.c
Date: Sun, 09 Apr 2006 19:09:15 +0400
Message-ID: <4439239B.7040800@sw.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080008020809090106060006"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:9915 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750772AbWDIPGL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Apr 2006 11:06:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Kirill Korotaev <dev@sw.ru>, devel@openvz.org

This is a multi-part message in MIME format.
--------------080008020809090106060006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Unlike my previously patches this one is not trivial and it is not tested
properly. I'm not an expert in ACPI-related questions therefore this patch may
be wrong.

Len, could you please check it carefully?

acpi_video_bus_get_one_device() and other functions in driver/acpi/video.c do
not release allocated memory on remove and on the error path.

Signed-off-by: Vasily Averin <vvs@sw.ru>

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

--------------080008020809090106060006
Content-Type: text/plain;
 name="diff-ms-acpi-video-20060409"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-acpi-video-20060409"

--- a/drivers/acpi/video.c	2006-03-20 08:53:29.000000000 +0300
+++ b/drivers/acpi/video.c	2006-04-09 18:34:38.000000000 +0400
@@ -1294,7 +1294,7 @@ acpi_video_bus_get_one_device(struct acp
 			      struct acpi_video_bus *video)
 {
 	unsigned long device_id;
-	int status, result;
+	int status;
 	struct acpi_video_device *data;
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_get_one_device");
@@ -1346,8 +1346,11 @@ acpi_video_bus_get_one_device(struct acp
 		if (ACPI_FAILURE(status)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 					  "Error installing notify handler\n"));
-			result = -ENODEV;
-			goto end;
+			if(data->brightness)
+				kfree(data->brightness->levels);
+			kfree(data->brightness);
+			kfree(data);
+			return_VALUE(-ENODEV);
 		}
 
 		down(&video->sem);
@@ -1358,8 +1361,6 @@ acpi_video_bus_get_one_device(struct acp
 
 		return_VALUE(0);
 	}
-
-      end:
 	return_VALUE(-ENOENT);
 }
 
@@ -1643,8 +1644,9 @@ static int acpi_video_bus_put_devices(st
 			printk(KERN_WARNING PREFIX
 			       "hhuuhhuu bug in acpi video driver.\n");
 
+		if (data->brightness);
+			kfree(data->brightness->levels);
 		kfree(data->brightness);
-
 		kfree(data);
 	}
 
@@ -1785,6 +1787,10 @@ static int acpi_video_bus_add(struct acp
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Error installing notify handler\n"));
+		acpi_video_bus_stop_devices(video);
+		acpi_video_bus_put_devices(video);
+		kfree(video->attached_array);
+		acpi_video_bus_remove_fs(device);
 		result = -ENODEV;
 		goto end;
 	}
@@ -1797,7 +1803,6 @@ static int acpi_video_bus_add(struct acp
 
       end:
 	if (result) {
-		acpi_video_bus_remove_fs(device);
 		kfree(video);
 	}
 

--------------080008020809090106060006--
