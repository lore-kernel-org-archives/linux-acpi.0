From: akpm@linux-foundation.org
Subject: [patch 2/6] ACPI video: don't export sysfs backlight interface if query _BCL fail
Date: Wed, 23 May 2007 14:12:26 -0700
Message-ID: <200705232112.l4NLCRUw032148@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:57412 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755898AbXEWVYu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 May 2007 17:24:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, dkukawka@suse.de, luming.yu@intel.com

From: Danny Kukawka <dkukawka@suse.de>

Currently the acpi video module export the backlight interface to sysfs
also if acpi_video_device_lcd_query_levels() fails to read _BLC method
(e.g.  because the method is not available).  In this case the userspace
don't know which brightness level are supported and can't set a brightness
level (echo return with: "write error: Invalid Argument").  This happend
e.g.  on a ASUS RF1 (correct supported by the asus-laptop module).

The video module should not export the backlight interface if query _BLC fail,
because you can't set anything from userspace and this make it useless.

See also: http://bugzilla.kernel.org/show_bug.cgi?id=8375

Signed-off-by: Danny Kukawka <dkukawka@suse.de>
Cc: "Yu, Luming" <luming.yu@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/video.c |   78 +++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 37 deletions(-)

diff -puN drivers/acpi/video.c~acpi-video-dont-export-sysfs-backlight-interface-if-query-_bcl-fail drivers/acpi/video.c
--- a/drivers/acpi/video.c~acpi-video-dont-export-sysfs-backlight-interface-if-query-_bcl-fail
+++ a/drivers/acpi/video.c
@@ -559,7 +559,6 @@ acpi_video_bus_DOS(struct acpi_video_bus
 
 static void acpi_video_device_find_cap(struct acpi_video_device *device)
 {
-	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
 	u32 max_level = 0;
@@ -593,50 +592,55 @@ static void acpi_video_device_find_cap(s
 		device->cap._DSS = 1;
 	}
 
-	status = acpi_video_device_lcd_query_levels(device, &obj);
+	if (ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
 
-	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
-		int count = 0;
-		union acpi_object *o;
-
-		br = kzalloc(sizeof(*br), GFP_KERNEL);
-		if (!br) {
-			printk(KERN_ERR "can't allocate memory\n");
-		} else {
-			br->levels = kmalloc(obj->package.count *
-					     sizeof *(br->levels), GFP_KERNEL);
-			if (!br->levels)
-				goto out;
-
-			for (i = 0; i < obj->package.count; i++) {
-				o = (union acpi_object *)&obj->package.
-				    elements[i];
-				if (o->type != ACPI_TYPE_INTEGER) {
-					printk(KERN_ERR PREFIX "Invalid data\n");
-					continue;
-				}
-				br->levels[count] = (u32) o->integer.value;
-				if (br->levels[count] > max_level)
-					max_level = br->levels[count];
-				count++;
-			}
-		      out:
-			if (count < 2) {
-				kfree(br->levels);
-				kfree(br);
+		if (obj->package.count >= 2) {
+			int count = 0;
+			union acpi_object *o;
+
+			br = kzalloc(sizeof(*br), GFP_KERNEL);
+			if (!br) {
+				printk(KERN_ERR "can't allocate memory\n");
 			} else {
-				br->count = count;
-				device->brightness = br;
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "found %d brightness levels\n",
-						  count));
+				br->levels = kmalloc(obj->package.count *
+						     sizeof *(br->levels), GFP_KERNEL);
+				if (!br->levels)
+					goto out;
+
+				for (i = 0; i < obj->package.count; i++) {
+					o = (union acpi_object *)&obj->package.
+					    elements[i];
+					if (o->type != ACPI_TYPE_INTEGER) {
+						printk(KERN_ERR PREFIX "Invalid data\n");
+						continue;
+					}
+					br->levels[count] = (u32) o->integer.value;
+
+					if (br->levels[count] > max_level)
+						max_level = br->levels[count];
+					count++;
+				}
+			      out:
+				if (count < 2) {
+					kfree(br->levels);
+					kfree(br);
+				} else {
+					br->count = count;
+					device->brightness = br;
+					ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+							  "found %d brightness levels\n",
+							  count));
+				}
 			}
 		}
+
+	} else {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available LCD brightness level\n"));
 	}
 
 	kfree(obj);
 
-	if (device->cap._BCL && device->cap._BCM && device->cap._BQC){
+	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
 		unsigned long tmp;
 		static int count = 0;
 		char *name;
_
