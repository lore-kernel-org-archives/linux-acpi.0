From: Yu Luming <luming.yu@intel.com>
Subject: RFC [patch] backlight sysfs support for video.c
Date: Wed, 16 Aug 2006 23:11:44 +0800
Message-ID: <200608162311.45620.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65311 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751209AbWHPPGD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Aug 2006 11:06:03 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


This patch  adds brightness sysfs support for acpi video driver
through backlight class. Any comments are appreciated.

--Luming

 Kconfig |    2 +-
 video.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

-- diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 56c5ba8..d5507ea 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -106,7 +106,7 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86
+	depends on X86 && BACKLIGHT_DEVICE
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 56666a9..26f5225 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -30,6 +30,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/backlight.h>
 
 #include <asm/uaccess.h>
 
@@ -141,11 +142,11 @@ struct acpi_video_device_cap {
 	u8 _ADR:1;		/*Return the unique ID */
 	u8 _BCL:1;		/*Query list of brightness control levels supported */
 	u8 _BCM:1;		/*Set the brightness level */
+	u8 _BQC:1;		/*Get current brightness level */
 	u8 _DDC:1;		/*Return the EDID for this device */
 	u8 _DCS:1;		/*Return status of output device */
 	u8 _DGS:1;		/*Query graphics state */
 	u8 _DSS:1;		/*Device state set */
-	u8 _reserved:1;
 };
 
 struct acpi_video_device_brightness {
@@ -260,6 +261,34 @@ static int acpi_video_get_next_level(str
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
+static int acpi_video_device_lcd_set_level(struct acpi_video_device *, int);
+static int acpi_video_device_lcd_get_level_current(struct acpi_video_device *,unsigned long *);
+/*backlight device sysfs support*/
+static int acpi_video_get_brightness(struct backlight_device *bd);
+static int acpi_video_set_brightness(struct backlight_device *bd);
+
+static struct backlight_device *acpi_video_backlight;
+static struct acpi_video_device *backlight_acpi_device;
+static struct backlight_properties acpi_video_data = {
+	.owner		= THIS_MODULE,
+	.max_brightness = 0,
+	.get_brightness = acpi_video_get_brightness,
+	.update_status  = acpi_video_set_brightness,
+};
+static int acpi_video_get_brightness(struct backlight_device *bd)
+{
+	unsigned long cur_level;
+	acpi_video_device_lcd_get_level_current(backlight_acpi_device, &cur_level);
+	return (int) cur_level; 
+}
+
+static int acpi_video_set_brightness(struct backlight_device *bd)
+{
+	int request_level = bd->props->brightness;
+	acpi_video_device_lcd_set_level(backlight_acpi_device, request_level);
+	return 0;
+}
+
 
 /* --------------------------------------------------------------------------
                                Video Management
@@ -498,6 +527,7 @@ static void acpi_video_device_find_cap(s
 	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
+	u32 max_level = 0;
 	union acpi_object *obj = NULL;
 	struct acpi_video_device_brightness *br = NULL;
 
@@ -513,6 +543,9 @@ static void acpi_video_device_find_cap(s
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCM", &h_dummy1))) {
 		device->cap._BCM = 1;
 	}
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BQC", &h_dummy1))) {
+		device->cap._BQC = 1;
+	}
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}
@@ -526,6 +559,7 @@ static void acpi_video_device_find_cap(s
 		device->cap._DSS = 1;
 	}
 
+
 	status = acpi_video_device_lcd_query_levels(device, &obj);
 
 	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
@@ -550,6 +584,8 @@ static void acpi_video_device_find_cap(s
 					continue;
 				}
 				br->levels[count] = (u32) o->integer.value;
+				if (br->levels[count] > max_level)
+					max_level = br->levels[count];
 				count++;
 			}
 		      out:
@@ -568,6 +604,16 @@ static void acpi_video_device_find_cap(s
 
 	kfree(obj);
 
+	if (device->cap._BCL && device->cap._BCM && device->cap._BQC){
+		unsigned long tmp;
+		acpi_video_data.max_brightness = max_level;
+		acpi_video_device_lcd_get_level_current(device, &tmp);
+		acpi_video_data.brightness = tmp;
+		acpi_video_backlight = backlight_device_register("acpi-video",
+			NULL, &acpi_video_data);
+		backlight_acpi_device = device;
+	}
+
 	return;
 }
 
@@ -1568,6 +1614,8 @@ static int acpi_video_bus_put_one_device
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
+	if (device == backlight_acpi_device)
+		backlight_device_unregister(acpi_video_backlight);
 
 	return 0;
 }

Thanks,
Luming
