From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Add the reference count to avoid unloading ACPI
	video bus twice
Date: Mon, 01 Jun 2009 13:44:14 +0800
Message-ID: <1243835054.3558.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56335 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbZFAFnF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Jun 2009 01:43:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Sometimes both acpi video and i915 driver are compiled as modules.
And there exists the strict dependency between the two drivers.
The acpi video bus will be unloaded in course of unloading the i915 driver.
If we unload the acpi video driver, then the kernel oops will be triggered.

Add the reference count to avoid unloading the ACPI video bus twice.
The reference count should be checked before unregistering the acpi video bus.
If the reference count is already zero, it won't unregister it again.
And after the acpi video bus is already unregistered, the reference count
will be set to zero.
At the same time the reference count is also checked when registering
the acpi video bus.

http://bugzilla.kernel.org/show_bug.cgi?id=13396

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/video.c                 |   42 ++++++++++++++++++++++++++++-------
 drivers/gpu/drm/i915/i915_opregion.c |    2 -
 include/acpi/video.h                 |    4 +--
 3 files changed, 37 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c	2009-05-31 09:33:17.000000000 +0800
+++ linux-2.6/drivers/acpi/video.c	2009-06-01 13:29:41.000000000 +0800
@@ -76,6 +76,7 @@
 static int brightness_switch_enabled = 1;
 module_param(brightness_switch_enabled, bool, 0644);
 
+static int video_atomic = 0;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 static int acpi_video_resume(struct acpi_device *device);
@@ -2302,7 +2303,13 @@
 int acpi_video_register(void)
 {
 	int result = 0;
-
+	if (video_atomic) {
+		/*
+		 * if the function of acpi_video_register is already called,
+		 * don't register the acpi_vide_bus again and return no error.
+		 */
+		return 0;
+	}
 	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
 	if (!acpi_video_dir)
 		return -ENODEV;
@@ -2312,11 +2319,34 @@
 		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
 		return -ENODEV;
 	}
-
+	/*
+	 * When the acpi_video_bus is loaded successfully, increase
+	 * the counter reference.
+	 */
+	video_atomic = 1;
 	return 0;
 }
 EXPORT_SYMBOL(acpi_video_register);
 
+void acpi_video_unregister(void)
+{
+	if (!video_atomic) {
+		/*
+		 * If the acpi video bus is already unloaded, don't
+		 * unload it again and return directly.
+		 */
+		return;
+	}
+	acpi_bus_unregister_driver(&acpi_video_bus);
+
+	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+
+	video_atomic = 0;
+
+	return;
+}
+EXPORT_SYMBOL(acpi_video_unregister);
+
 /*
  * This is kind of nasty. Hardware using Intel chipsets may require
  * the video opregion code to be run first in order to initialise
@@ -2334,16 +2364,12 @@
 	return acpi_video_register();
 }
 
-void __exit acpi_video_exit(void)
+static void __exit acpi_video_exit(void)
 {
-
-	acpi_bus_unregister_driver(&acpi_video_bus);
-
-	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+	acpi_video_unregister();
 
 	return;
 }
-EXPORT_SYMBOL(acpi_video_exit);
 
 module_init(acpi_video_init);
 module_exit(acpi_video_exit);
Index: linux-2.6/include/acpi/video.h
===================================================================
--- linux-2.6.orig/include/acpi/video.h	2009-04-29 09:32:00.000000000 +0800
+++ linux-2.6/include/acpi/video.h	2009-06-01 13:34:19.000000000 +0800
@@ -3,10 +3,10 @@
 
 #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
 extern int acpi_video_register(void);
-extern int acpi_video_exit(void);
+extern void acpi_video_unregister(void);
 #else
 static inline int acpi_video_register(void) { return 0; }
-static inline void acpi_video_exit(void) { return; }
+static inline void acpi_video_unregister(void) { return; }
 #endif
 
 #endif
Index: linux-2.6/drivers/gpu/drm/i915/i915_opregion.c
===================================================================
--- linux-2.6.orig/drivers/gpu/drm/i915/i915_opregion.c	2009-04-29 09:32:00.000000000 +0800
+++ linux-2.6/drivers/gpu/drm/i915/i915_opregion.c	2009-06-01 12:02:00.000000000 +0800
@@ -419,7 +419,7 @@
 		return;
 
 	if (!suspend)
-		acpi_video_exit();
+		acpi_video_unregister();
 
 	opregion->acpi->drdy = 0;
 


