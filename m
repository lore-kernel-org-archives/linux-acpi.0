From: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/77] ACPI: video: output switch sysfs support
Date: Sun, 22 Jul 2007 05:13:50 -0400
Message-ID: <11850957073494-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47794 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761954AbXGVJPI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:08 -0400
In-Reply-To: <11850957062754-git-send-email-len.brown@intel.com>
Message-Id: <23b0f015bf2c050b8b5399430ca64e1b3398cf76.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luming Yu <luming.yu@gmail.com>, Luming Yu <Luming.yu@intel.com>, Len Brown <len.brown@intel.com>

From: Luming Yu <luming.yu@gmail.com>

Requires CONFIG_VIDEO_OUTPUT_CONTROL and CONFIG_ACPI_VIDEO.

After loading output.ko and video.ko, you would have
/sys/class/video_output and several device acpi_videoNum there.

For example, I got acpi_video0, acpi_video1,acpi_video2,and acpi_video3
under /sys/class/video_output on my T40.
I can query the status of  output device0 by running " cat
/sys/class/video_output/acpi_video0
" The return value is defined in ACPI SPEC B.5.5 _DCS(Return the
Status of Output Device).  Also you can turn off video1 and turn on
video0  by " echo 0 > acpi_video1; echo 0x80000000 > acpi_video0".
Please reference ACPI SPEC  B.5.7 _DSS for the parameter definition.

Please note that it may or may NOT works purely depending on if
your vendor providing correct ACPI video extension support in bios.
the driver output.ko and video.ko just works like a interface to
invoke BIOS.

Signed-off-by: Luming Yu <Luming.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig   |    2 +-
 drivers/acpi/video.c   |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/video/Kconfig  |    7 +++++++
 drivers/video/Makefile |    3 +++
 4 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 139f41f..eb4855f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -124,7 +124,7 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86 && BACKLIGHT_CLASS_DEVICE
+	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 00d25b3..39273da 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -33,6 +33,7 @@
 #include <linux/seq_file.h>
 
 #include <linux/backlight.h>
+#include <linux/video_output.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -169,6 +170,7 @@ struct acpi_video_device {
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
 	struct backlight_device *backlight;
+	struct output_device *output_dev;
 };
 
 /* bus */
@@ -272,6 +274,10 @@ static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
+static int acpi_video_device_get_state(struct acpi_video_device *device,
+			    unsigned long *state);
+static int acpi_video_output_get(struct output_device *od);
+static int acpi_video_device_set_state(struct acpi_video_device *device, int state);
 
 /*backlight device sysfs support*/
 static int acpi_video_get_brightness(struct backlight_device *bd)
@@ -297,6 +303,28 @@ static struct backlight_ops acpi_backlight_ops = {
 	.update_status  = acpi_video_set_brightness,
 };
 
+/*video output device sysfs support*/
+static int acpi_video_output_get(struct output_device *od)
+{
+	unsigned long state;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	acpi_video_device_get_state(vd, &state);
+	return (int)state;
+}
+
+static int acpi_video_output_set(struct output_device *od)
+{
+	unsigned long state = od->request_state;
+	struct acpi_video_device *vd=
+		(struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	return acpi_video_device_set_state(vd, state);
+}
+
+static struct output_properties acpi_output_properties = {
+	.set_state = acpi_video_output_set,
+	.get_status = acpi_video_output_get,
+};
 /* --------------------------------------------------------------------------
                                Video Management
    -------------------------------------------------------------------------- */
@@ -626,6 +654,17 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 
 		kfree(name);
 	}
+	if (device->cap._DCS && device->cap._DSS){
+		static int count = 0;
+		char *name;
+		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+		if (!name)
+			return;
+		sprintf(name, "acpi_video%d", count++);
+		device->output_dev = video_output_register(name,
+				NULL, device, &acpi_output_properties);
+		kfree(name);
+	}
 	return;
 }
 
@@ -1669,6 +1708,7 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
 	backlight_device_unregister(device->backlight);
+	video_output_unregister(device->output_dev);
 	return 0;
 }
 
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 1132ba5..6c8ffe6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -11,6 +11,13 @@ config VGASTATE
        tristate
        default n
 
+config VIDEO_OUTPUT_CONTROL
+	tristate "Lowlevel video output switch controls"
+	default m
+	help
+	  This framework adds support for low-level control of the video 
+	  output switch.
+
 config FB
 	tristate "Support for frame buffer devices"
 	---help---
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index a916c20..08b7c26 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -119,3 +119,6 @@ obj-$(CONFIG_FB_OF)               += offb.o
 
 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
+
+#video output switch sysfs driver
+obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o
-- 
1.5.3.rc2.22.g69a9b
