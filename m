From: Len Brown <len.brown@intel.com>
Subject: [PATCH 29/77] ACPI video: Don't export sysfs backlight interface if query _BCL fail
Date: Sun, 22 Jul 2007 05:14:14 -0400
Message-ID: <11850957323059-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14984 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762914AbXGVJPe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:34 -0400
In-Reply-To: <11850957311269-git-send-email-len.brown@intel.com>
Message-Id: <f70ac0e9651aa8c07dffe72a44872f92054d42c3.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Danny Kukawka <dkukawka@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Danny Kukawka <dkukawka@suse.de>

Currently the acpi video module export the backlight interface to sysfs
also if acpi_video_device_lcd_query_levels() fails to read _BLC method
(e.g.  because the method is not available).  In this case the userspace
don't know which brightness level are supported and can't set a brightness
level (echo return with: "write error: Invalid Argument").  This happend
e.g.  on a ASUS RF1 (correct supported by the asus-laptop module).

The video module should not export the backlight interface if query _BLC fail,
because you can't set anything from userspace and this make it useless.

http://bugzilla.kernel.org/show_bug.cgi?id=8375

Signed-off-by: Danny Kukawka <dkukawka@suse.de>
Acked-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   80 ++++++++++++++++++++++++++-----------------------
 1 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 39273da..5f014d3 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -559,7 +559,6 @@ acpi_video_bus_DOS(struct acpi_video_bus *video, int bios_flag, int lcd_flag)
 
 static void acpi_video_device_find_cap(struct acpi_video_device *device)
 {
-	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
 	u32 max_level = 0;
@@ -593,50 +592,55 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		device->cap._DSS = 1;
 	}
 
-	status = acpi_video_device_lcd_query_levels(device, &obj);
-
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
+	if (ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
+
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
-- 
1.5.3.rc2.22.g69a9b
