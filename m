From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/23] dell-laptop: move to drivers/platform/x86/ from
 drivers/misc/
Date: Fri, 16 Jan 2009 15:25:10 -0500
Message-ID: <cad73120ab0dfd484682229346de8c16073577e1.1232137453.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:43575 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759589AbZAPUZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK00F5LZEBQNX7@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:24 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Makefile                        |    1 -
 drivers/platform/x86/Kconfig                 |   12 ++++++++++++
 drivers/platform/x86/Makefile                |    1 +
 drivers/{misc => platform/x86}/dell-laptop.c |    2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)
 rename drivers/{misc => platform/x86}/dell-laptop.c (99%)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9cf8ae6..d5749a7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
-obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
 obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e65448e..9e8f948 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -54,6 +54,18 @@ config ASUS_LAPTOP
 
 	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
 
+config DELL_LAPTOP
+	tristate "Dell Laptop Extras (EXPERIMENTAL)"
+	depends on X86
+	depends on DCDBAS
+	depends on EXPERIMENTAL
+	depends on BACKLIGHT_CLASS_DEVICE
+	depends on RFKILL
+	default n
+	---help---
+	This driver adds support for rfkill and backlight control to Dell
+	laptops.
+
 config FUJITSU_LAPTOP
 	tristate "Fujitsu Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1e9de2a..e290651 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
 obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
+obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop.o
 obj-$(CONFIG_ACER_WMI)		+= acer-wmi.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/misc/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
similarity index 99%
rename from drivers/misc/dell-laptop.c
rename to drivers/platform/x86/dell-laptop.c
index 4d33a20..16e11c2 100644
--- a/drivers/misc/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -22,7 +22,7 @@
 #include <linux/rfkill.h>
 #include <linux/power_supply.h>
 #include <linux/acpi.h>
-#include "../firmware/dcdbas.h"
+#include "../../firmware/dcdbas.h"
 
 #define BRIGHTNESS_TOKEN 0x7d
 
-- 
1.5.6.6

