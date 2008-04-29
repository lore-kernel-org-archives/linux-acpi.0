From: Len Brown <lenb@kernel.org>
Subject: [PATCH 094/171] thermal: add the support for building the generic thermal as a module
Date: Tue, 29 Apr 2008 04:44:14 -0400
Message-ID: <63c4ec905d63834a97ec7dbbf0a2ec89ef5872be.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28120 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760661AbYD2IpL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:11 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Build the generic thermal driver as module "thermal_sys".

Make ACPI thermal, video, processor and fan SELECT the generic
thermal driver, as these drivers rely on it to build the sysfs I/F.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig      |    3 +++
 drivers/misc/Kconfig      |    1 +
 drivers/thermal/Kconfig   |    4 ++--
 drivers/thermal/Makefile  |    3 ++-
 drivers/thermal/thermal.c |    2 +-
 include/linux/thermal.h   |   14 --------------
 6 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b4f5e85..c52fca8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
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
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 297a48f..08f35d7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -344,6 +344,7 @@ config ATMEL_SSC
 config INTEL_MENLOW
 	tristate "Thermal Management driver for Intel menlow platform"
 	depends on ACPI_THERMAL
+	select THERMAL
 	depends on X86
 	---help---
 	  ACPI thermal management enhancement driver on
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 17e71d5..4b62852 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
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
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8ef1232..02b6451 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -2,4 +2,5 @@
 # Makefile for sensor chip drivers.
 #
 
-obj-$(CONFIG_THERMAL)		+= thermal.o
+thermal_sys-objs	+= thermal.o
+obj-$(CONFIG_THERMAL)		+= thermal_sys.o
diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
index 7f79bbf..cf56af4 100644
--- a/drivers/thermal/thermal.c
+++ b/drivers/thermal/thermal.c
@@ -31,7 +31,7 @@
 #include <linux/thermal.h>
 #include <linux/spinlock.h>
 
-MODULE_AUTHOR("Zhang Rui")
+MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 90c1c19..3ff680b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -88,24 +88,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
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
-- 
1.5.5.1.99.gf0ec4

