From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH 1/6] thermal: add the support for building the generic
	thermal as a module
Date: Thu, 10 Apr 2008 16:11:54 +0800
Message-ID: <1207815114.27304.32.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37194 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826AbYDJI3c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 04:29:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>

Build the generic thermal driver as module "thermal_sys".

Make ACPI thermal, video, processor and fan SELECT the generic
thermal driver, as these drivers rely on it to build the sysfs I/F.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig      |    4 +++-
 drivers/thermal/Kconfig   |    4 ++--
 drivers/thermal/Makefile  |    3 ++-
 drivers/thermal/thermal.c |    2 +-
 include/linux/thermal.h   |   14 --------------
 5 files changed, 8 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/thermal/Kconfig
===================================================================
--- linux-2.6.orig/drivers/thermal/Kconfig
+++ linux-2.6/drivers/thermal/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig THERMAL
-	bool "Generic Thermal sysfs driver"
+	tristate "Generic Thermal sysfs driver"
 	help
 	  Generic Thermal Sysfs driver offers a generic mechanism for
 	  thermal management. Usually it's made up of one or more thermal
@@ -11,4 +11,4 @@ menuconfig THERMAL
 	  Each thermal zone contains its own temperature, trip points,
 	  cooling devices.
 	  All platforms with ACPI thermal support can use this driver.
-	  If you want this support, you should say Y here.
+	  If you want this support, you should say Y or M here.
Index: linux-2.6/drivers/thermal/thermal.c
===================================================================
--- linux-2.6.orig/drivers/thermal/thermal.c
+++ linux-2.6/drivers/thermal/thermal.c
@@ -31,7 +31,7 @@
 #include <linux/thermal.h>
 #include <linux/spinlock.h>
 
-MODULE_AUTHOR("Zhang Rui")
+MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
Index: linux-2.6/drivers/thermal/Makefile
===================================================================
--- linux-2.6.orig/drivers/thermal/Makefile
+++ linux-2.6/drivers/thermal/Makefile
@@ -2,4 +2,5 @@
 # Makefile for sensor chip drivers.
 #
 
-obj-$(CONFIG_THERMAL)		+= thermal.o
+thermal_sys-objs	+= thermal.o
+obj-$(CONFIG_THERMAL)		+= thermal_sys.o
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -140,6 +140,7 @@ config ACPI_VIDEO
 	tristate "Video"
 	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
 	depends on INPUT
+	select THERMAL
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
@@ -151,6 +152,7 @@ config ACPI_VIDEO
 
 config ACPI_FAN
 	tristate "Fan"
+	select THERMAL
 	default y
 	help
 	  This driver adds support for ACPI fan devices, allowing user-mode 
@@ -172,6 +174,7 @@ config ACPI_BAY
 
 config ACPI_PROCESSOR
 	tristate "Processor"
+	select THERMAL
 	default y
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses
@@ -188,7 +191,6 @@ config ACPI_HOTPLUG_CPU
 config ACPI_THERMAL
 	tristate "Thermal Zone"
 	depends on ACPI_PROCESSOR
-	select THERMAL
 	default y
 	help
 	  This driver adds support for ACPI thermal zones.  Most mobile and
Index: linux-2.6/include/linux/thermal.h
===================================================================
--- linux-2.6.orig/include/linux/thermal.h
+++ linux-2.6/include/linux/thermal.h
@@ -88,24 +88,10 @@ int thermal_zone_bind_cooling_device(str
 				     struct thermal_cooling_device *);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
-
-#ifdef	CONFIG_THERMAL
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 							       struct
 							       thermal_cooling_device_ops
 							       *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
-#else
-static inline struct thermal_cooling_device
-*thermal_cooling_device_register(char *c, void *v,
-				 struct thermal_cooling_device_ops *t)
-{
-	return NULL;
-}
-static inline
-    void thermal_cooling_device_unregister(struct thermal_cooling_device *t)
-{
-};
-#endif
 
 #endif /* __THERMAL_H__ */


