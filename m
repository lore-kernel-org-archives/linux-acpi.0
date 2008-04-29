From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] ACPI: video - do not store invalid entries in attached_array list
Date: Tue, 29 Apr 2008 11:14:21 -0400
Message-ID: <78eed028f13b1a0b2612368dff3786e400e6cf8b.1209480940.git.len.brown@intel.com>
References: <1209482064-25440-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6427 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755584AbYD2PO2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 11:14:28 -0400
In-Reply-To: <1209482064-25440-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

this is a cleanup, not a change to function.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   58 +++++++++++++++++++++++--------------------------
 1 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 980a741..3f0e4bc 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -57,8 +57,6 @@
 #define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x88
 #define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
 
-#define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
-#define ACPI_VIDEO_HEAD_END		(~0u)
 #define MAX_NAME_LEN	20
 
 #define ACPI_VIDEO_DISPLAY_CRT	1
@@ -1440,11 +1438,15 @@ static int acpi_video_bus_remove_fs(struct acpi_device *device)
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
 
@@ -1571,20 +1573,16 @@ static void
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
@@ -1603,7 +1601,7 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 	int status;
 	int count;
 	int i;
-	struct acpi_video_enumerated_device *active_device_list;
+	struct acpi_video_enumerated_device *active_list;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *dod = NULL;
 	union acpi_object *obj;
@@ -1624,13 +1622,10 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
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
@@ -1640,23 +1635,24 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
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
1.5.5.1.99.gf0ec4

