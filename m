From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [patch 5/8] ACPI: video - simplify handling of attached devices
Date: Mon, 05 Nov 2007 11:43:33 -0500
Message-ID: <20071105165012.325585770@anvil.corenet.prv>
References: <20071105164328.982283020@anvil.corenet.prv>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:36139 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXKEQwo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2007 11:52:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2045458wah
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 08:52:44 -0800 (PST)
Content-Disposition: inline; filename=acpi-video-attached-confusion.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

ACPI: video - simplify handling of attached devices

The old code needlessly stored invalid entries in attached_array list.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/acpi/video.c |   58 +++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

Index: work/drivers/acpi/video.c
===================================================================
--- work.orig/drivers/acpi/video.c
+++ work/drivers/acpi/video.c
@@ -56,8 +56,6 @@
 #define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x88
 #define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
 
-#define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
-#define ACPI_VIDEO_HEAD_END		(~0u)
 #define MAX_NAME_LEN	20
 
 #define ACPI_VIDEO_DISPLAY_CRT	1
@@ -1359,11 +1357,15 @@ static int acpi_video_bus_remove_fs(stru
 static struct acpi_video_device_attrib*
 acpi_video_get_device_attr(struct acpi_video_bus *video, unsigned long device_id)
 {
-	int count;
+	struct acpi_video_enumerated_device *ids;
+	int i;
+
+	for (i = 0; i < video->attached_count; i++) {
+		ids = &video->attached_array[i];
+		if ((ids->value.int_val & 0xffff) == device_id)
+			return &ids->value.attrib;
+	}
 
-	for(count = 0; count < video->attached_count; count++)
-		if((video->attached_array[count].value.int_val & 0xffff) == device_id)
-			return &(video->attached_array[count].value.attrib);
 	return NULL;
 }
 
@@ -1490,20 +1492,16 @@ static void
 acpi_video_device_bind(struct acpi_video_bus *video,
 		       struct acpi_video_device *device)
 {
+	struct acpi_video_enumerated_device *ids;
 	int i;
 
-#define IDS_VAL(i) video->attached_array[i].value.int_val
-#define IDS_BIND(i) video->attached_array[i].bind_info
-
-	for (i = 0; IDS_VAL(i) != ACPI_VIDEO_HEAD_INVALID &&
-	     i < video->attached_count; i++) {
-		if (device->device_id == (IDS_VAL(i) & 0xffff)) {
-			IDS_BIND(i) = device;
+	for (i = 0; i < video->attached_count; i++) {
+		ids = &video->attached_array[i];
+		if (device->device_id == (ids->value.int_val & 0xffff)) {
+			ids->bind_info = device;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "device_bind %d\n", i));
 		}
 	}
-#undef IDS_VAL
-#undef IDS_BIND
 }
 
 /*
@@ -1522,7 +1520,7 @@ static int acpi_video_device_enumerate(s
 	int status;
 	int count;
 	int i;
-	struct acpi_video_enumerated_device *active_device_list;
+	struct acpi_video_enumerated_device *active_list;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *dod = NULL;
 	union acpi_object *obj;
@@ -1543,13 +1541,10 @@ static int acpi_video_device_enumerate(s
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d video heads in _DOD\n",
 			  dod->package.count));
 
-	active_device_list = kmalloc((1 +
-				      dod->package.count) *
-				     sizeof(struct
-					    acpi_video_enumerated_device),
-				     GFP_KERNEL);
-
-	if (!active_device_list) {
+	active_list = kcalloc(1 + dod->package.count,
+			      sizeof(struct acpi_video_enumerated_device),
+			      GFP_KERNEL);
+	if (!active_list) {
 		status = -ENOMEM;
 		goto out;
 	}
@@ -1559,23 +1554,24 @@ static int acpi_video_device_enumerate(s
 		obj = &dod->package.elements[i];
 
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			printk(KERN_ERR PREFIX "Invalid _DOD data\n");
-			active_device_list[i].value.int_val =
-			    ACPI_VIDEO_HEAD_INVALID;
+			printk(KERN_ERR PREFIX
+				"Invalid _DOD data in element %d\n", i);
+			continue;
 		}
-		active_device_list[i].value.int_val = obj->integer.value;
-		active_device_list[i].bind_info = NULL;
+
+		active_list[count].value.int_val = obj->integer.value;
+		active_list[count].bind_info = NULL;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = %d\n", i,
 				  (int)obj->integer.value));
 		count++;
 	}
-	active_device_list[count].value.int_val = ACPI_VIDEO_HEAD_END;
 
 	kfree(video->attached_array);
 
-	video->attached_array = active_device_list;
+	video->attached_array = active_list;
 	video->attached_count = count;
-      out:
+
+ out:
 	kfree(buffer.pointer);
 	return status;
 }

-- 
Dmitry

