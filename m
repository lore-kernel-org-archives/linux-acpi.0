From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH 2/2]: ACPI: Weaken the dependency between ACPI video driver
	and I915
Date: Tue, 14 Apr 2009 11:06:51 +0800
Message-ID: <1239678411.5564.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2855 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbZDNDFb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 23:05:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Now there exists the tight dependency between the ACPI video driver and
i915 driver. If the I915 driver is compiled as built-in module and the
acpi video is compiled as module, it will fail in the kernel compilation.

At the same time the acpi video driver must be loaded in order to load
the I915 driver. It is very hack.

This patch is to weaken the dependency between the ACPI video driver and
i915 driver. But it still can do what we expected.

a. the i915/acpi_video_register is defined in the video_detect.When the
video is choosed, it will be complied as built-in functions. If the video
is not choosed, it is defined as inline function.
b. i915_video_register is called by i915 driver. And i915 video flag is set.
c. acpi_video_register/unregister is called by acpi video driver. The acpi
video bus driver is hooked and the ACPI video flag is set.
d. When the both flag bits are set, the acpi video bus driver will be
registered.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Matthew Garrett <mjg59@srcf.ucam.org>

---
 drivers/acpi/video.c                 |   39 ++++++++----------
 drivers/acpi/video_detect.c          |   74 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/i915/i915_opregion.c |    2 
 include/acpi/video.h                 |   11 ++++-
 4 files changed, 101 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c	2009-04-14 10:28:12.000000000 +0800
+++ linux-2.6/drivers/acpi/video.c	2009-04-14 10:30:07.000000000 +0800
@@ -43,8 +43,8 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/video.h>
 
-#define ACPI_VIDEO_CLASS		"video"
 #define ACPI_VIDEO_BUS_NAME		"Video Bus"
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
 #define ACPI_VIDEO_NOTIFY_SWITCH	0x80
@@ -2260,7 +2260,16 @@
 	return 0;
 }
 
-int acpi_video_register(void)
+/*
+ * This is kind of nasty. Hardware using Intel chipsets may require
+ * the video opregion code to be run first in order to initialise
+ * state before any ACPI video calls are made. To handle this we defer
+ * registration of the video class until the opregion code has run.
+ * If there is no opregion is supported, it will continue the original
+ * flowchart. Register the ACPI video bus driver.
+ */
+
+static int __init acpi_video_init(void)
 {
 	int result = 0;
 
@@ -2268,34 +2277,22 @@
 	if (!acpi_video_dir)
 		return -ENODEV;
 
+	if (intel_opregion_present()) {
+		acpi_video_register(&acpi_video_bus);
+		return 0;
+	}
 	result = acpi_bus_register_driver(&acpi_video_bus);
+
 	if (result < 0) {
 		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-		return -ENODEV;
 	}
 
-	return 0;
-}
-EXPORT_SYMBOL(acpi_video_register);
-
-/*
- * This is kind of nasty. Hardware using Intel chipsets may require
- * the video opregion code to be run first in order to initialise
- * state before any ACPI video calls are made. To handle this we defer
- * registration of the video class until the opregion code has run.
- */
-
-static int __init acpi_video_init(void)
-{
-	if (intel_opregion_present())
-		return 0;
-
-	return acpi_video_register();
+	return result;
 }
 
 static void __exit acpi_video_exit(void)
 {
-
+	acpi_video_unregister(&acpi_video_bus);
 	acpi_bus_unregister_driver(&acpi_video_bus);
 
 	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
Index: linux-2.6/drivers/acpi/video_detect.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video_detect.c	2009-04-14 10:26:30.000000000 +0800
+++ linux-2.6/drivers/acpi/video_detect.c	2009-04-14 10:29:50.000000000 +0800
@@ -36,13 +36,22 @@
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <acpi/video.h>
+#include <acpi/acpi_bus.h>
 
 ACPI_MODULE_NAME("video");
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 
+#define I915_VIDEO_REGISTER	0x01
+#define ACPI_VIDEO_REGISTER	0x02
+#define VIDEO_REGISTER		0x03
 static long acpi_video_support;
 static bool acpi_video_caps_checked;
-
+struct video_register {
+	void *private_data;
+	unsigned int video_flags;
+};
+static struct video_register video_register_data;
 static acpi_status
 acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
 			  void **retyurn_value)
@@ -63,7 +72,70 @@
 	}
 	return 0;
 }
+static int video_register(void)
+{
+	int result = 0;
+
+	if (video_register_data.video_flags == VIDEO_REGISTER) {
+		/*
+		 * When both flag bits are set, we will register the ACPI
+		 * bus device driver.
+		 */
+		struct acpi_driver *video_driver = (struct acpi_driver *)
+				video_register_data.private_data;
+
+		result = acpi_bus_register_driver(video_driver);
+		if (result < 0)
+			remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+	}
+
+	return result;
+}
+/*
+ *  After the I915 driver is loaded, this function will resume the
+ *  deferrable flowchart of registering the ACPI video bus driver.
+ */
+int i915_video_register(void)
+{
+	int result = 0;
+
+	video_register_data.video_flags |= I915_VIDEO_REGISTER;
+	result = video_register();
+
+	return result;
+}
+EXPORT_SYMBOL(i915_video_register);
 
+int acpi_video_register(struct acpi_driver *video_driver)
+{
+	int result = 0;
+
+	if (!video_driver) {
+		/*
+		 * the ACPI_VIDEO_REGISTER flag will be clear if NULL pointer
+		 * is passed.
+		 */
+		video_register_data.video_flags &= ~ACPI_VIDEO_REGISTER;
+		video_register_data.private_data = NULL;
+		return 1;
+	}
+
+	video_register_data.video_flags |= ACPI_VIDEO_REGISTER;
+	video_register_data.private_data = (void *)video_driver;
+
+	result = video_register();
+
+	return result;
+}
+EXPORT_SYMBOL(acpi_video_register);
+
+int acpi_video_unregister(struct acpi_driver *video_driver)
+{
+	video_register_data.video_flags &= ~ACPI_VIDEO_REGISTER;
+	video_register_data.private_data = NULL;
+	return 0;
+}
+EXPORT_SYMBOL(acpi_video_unregister);
 /* Returns true if the device is a video device which can be handled by
  * video.ko.
  * The device will get a Linux specific CID added in scan.c to
Index: linux-2.6/include/acpi/video.h
===================================================================
--- linux-2.6.orig/include/acpi/video.h	2009-04-14 10:26:30.000000000 +0800
+++ linux-2.6/include/acpi/video.h	2009-04-14 10:29:50.000000000 +0800
@@ -1,10 +1,17 @@
 #ifndef __ACPI_VIDEO_H
 #define __ACPI_VIDEO_H
 
+#define ACPI_VIDEO_CLASS 	"video"
 #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
-extern int acpi_video_register(void);
+extern int acpi_video_register(struct acpi_driver *driver);
+extern int acpi_video_unregister(struct acpi_driver *driver);
+extern int i915_video_register(void);
 #else
-static inline int acpi_video_register(void) { return 0; }
+static inline int acpi_video_register(struct acpi_driver *driver)
+		{ return 0; }
+static inline int acpi_video_unregister(struct acpi_driver *driver)
+		{ return 0; }
+static inline int i915_video_register(void) { return 0; }
 #endif
 
 #endif
Index: linux-2.6/drivers/gpu/drm/i915/i915_opregion.c
===================================================================
--- linux-2.6.orig/drivers/gpu/drm/i915/i915_opregion.c	2009-04-14 10:26:30.000000000 +0800
+++ linux-2.6/drivers/gpu/drm/i915/i915_opregion.c	2009-04-14 10:29:50.000000000 +0800
@@ -373,7 +373,7 @@
 		if (drm_core_check_feature(dev, DRIVER_MODESET)) {
 			intel_didl_outputs(dev);
 			if (!resume)
-				acpi_video_register();
+				i915_video_register();
 		}
 	} else {
 		DRM_DEBUG("Public ACPI methods not supported\n");


