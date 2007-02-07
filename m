From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/140] ACPI: Adds backlight sysfs support for acpi video driver.
Date: Wed,  7 Feb 2007 13:50:29 -0500
Message-ID: <11708743943108-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7926 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422716AbXBGSxR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:17 -0500
In-Reply-To: <1170874393736-git-send-email-lenb@kernel.org>
Message-Id: <2f3d000a133f68250635f14f6caf24d32d358090.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yu Luming <luming.yu@gmail.com>, Luming Yu <Luming.yu@intel.com>, Len Brown <len.brown@intel.com>

From: Yu Luming <luming.yu@gmail.com>

Adds backlight sysfs support for acpi video driver.

signed-off-by: Luming Yu <Luming.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    2 +-
 drivers/acpi/video.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6f8c50e..e3f77e2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -106,7 +106,7 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86
+	depends on X86 && BACKLIGHT_CLASS_DEVICE
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 9200a46..4b09a02 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -32,6 +32,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <linux/backlight.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -56,6 +57,7 @@
 
 #define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
 #define ACPI_VIDEO_HEAD_END		(~0u)
+#define MAX_NAME_LEN	20
 
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 ACPI_MODULE_NAME("acpi_video")
@@ -142,11 +144,11 @@ struct acpi_video_device_cap {
 	u8 _ADR:1;		/*Return the unique ID */
 	u8 _BCL:1;		/*Query list of brightness control levels supported */
 	u8 _BCM:1;		/*Set the brightness level */
+	u8 _BQC:1;		/* Get current brightness level */
 	u8 _DDC:1;		/*Return the EDID for this device */
 	u8 _DCS:1;		/*Return status of output device */
 	u8 _DGS:1;		/*Query graphics state */
 	u8 _DSS:1;		/*Device state set */
-	u8 _reserved:1;
 };
 
 struct acpi_video_device_brightness {
@@ -163,6 +165,8 @@ struct acpi_video_device {
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
+	struct backlight_device *backlight;
+	struct backlight_properties *data;
 };
 
 /* bus */
@@ -257,11 +261,35 @@ static void acpi_video_device_bind(struct acpi_video_bus *video,
 				   struct acpi_video_device *device);
 static int acpi_video_device_enumerate(struct acpi_video_bus *video);
 static int acpi_video_switch_output(struct acpi_video_bus *video, int event);
+static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
+			int level);
+static int acpi_video_device_lcd_get_level_current(
+			struct acpi_video_device *device,
+			unsigned long *level);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
 
+/*backlight device sysfs support*/
+static int acpi_video_get_brightness(struct backlight_device *bd)
+{
+	unsigned long cur_level;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&bd->class_dev);
+	acpi_video_device_lcd_get_level_current(vd, &cur_level);
+	return (int) cur_level;
+}
+
+static int acpi_video_set_brightness(struct backlight_device *bd)
+{
+	int request_level = bd->props->brightness;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&bd->class_dev);
+	acpi_video_device_lcd_set_level(vd, request_level);
+	return 0;
+}
+
 /* --------------------------------------------------------------------------
                                Video Management
    -------------------------------------------------------------------------- */
@@ -499,6 +527,7 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
+	u32 max_level = 0;
 	union acpi_object *obj = NULL;
 	struct acpi_video_device_brightness *br = NULL;
 
@@ -514,6 +543,8 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCM", &h_dummy1))) {
 		device->cap._BCM = 1;
 	}
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BQC",&h_dummy1)))
+		device->cap._BQC = 1;
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}
@@ -551,6 +582,8 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 					continue;
 				}
 				br->levels[count] = (u32) o->integer.value;
+				if (br->levels[count] > max_level)
+					max_level = br->levels[count];
 				count++;
 			}
 		      out:
@@ -569,6 +602,37 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 
 	kfree(obj);
 
+	if (device->cap._BCL && device->cap._BCM && device->cap._BQC){
+		unsigned long tmp;
+		static int count = 0;
+		char *name;
+		struct backlight_properties *acpi_video_data;
+
+		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+		if (!name)
+			return;
+
+		acpi_video_data = kzalloc(
+			sizeof(struct backlight_properties),
+			GFP_KERNEL);
+		if (!acpi_video_data){
+			kfree(name);
+			return;
+		}
+		acpi_video_data->owner = THIS_MODULE;
+		acpi_video_data->get_brightness =
+			acpi_video_get_brightness;
+		acpi_video_data->update_status =
+			acpi_video_set_brightness;
+		sprintf(name, "acpi_video%d", count++);
+		device->data = acpi_video_data;
+		acpi_video_data->max_brightness = max_level;
+		acpi_video_device_lcd_get_level_current(device, &tmp);
+		acpi_video_data->brightness = (int)tmp;
+		device->backlight = backlight_device_register(name,
+			NULL, device, acpi_video_data);
+		kfree(name);
+	}
 	return;
 }
 
@@ -1595,7 +1659,10 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
-
+	if (device->backlight){
+		backlight_device_unregister(device->backlight);
+		kfree(device->data);
+	}
 	return 0;
 }
 
-- 
1.5.0.rc3.39.gec804
