From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH 1/3] thermal: build generic thermal driver as a module
Date: Wed, 02 Apr 2008 16:07:25 +0800
Message-ID: <1207123645.27304.3.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26216 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbYDBI33 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Apr 2008 04:29:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>

The generic thermal driver can be built as module "thermal_sys",
which give us more flexibility both at build time and
when bugs are reported.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig   |    4 ++--
 drivers/thermal/Makefile  |    3 ++-
 drivers/thermal/thermal.c |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

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


