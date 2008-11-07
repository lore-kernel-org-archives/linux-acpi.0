From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/5] ACPI: consolidate ACPI_*_COMPONENT definitions in
	acpi_drivers.h
Date: Fri, 07 Nov 2008 16:57:45 -0700
Message-ID: <20081107235745.32050.55869.stgit@bob.kio>
References: <20081107235644.32050.74757.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:8249 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbYKGX5q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 18:57:46 -0500
In-Reply-To: <20081107235644.32050.74757.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>

Move all the component definitions for drivers to a single shared place,
include/acpi/acpi_drivers.h.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/ac.c                   |    1 -
 drivers/acpi/acpi_memhotplug.c      |    1 -
 drivers/acpi/battery.c              |    1 -
 drivers/acpi/button.c               |    1 -
 drivers/acpi/cm_sbs.c               |    1 -
 drivers/acpi/container.c            |    1 -
 drivers/acpi/fan.c                  |    1 -
 drivers/acpi/power.c                |    3 +--
 drivers/acpi/processor_core.c       |    1 -
 drivers/acpi/processor_idle.c       |    1 -
 drivers/acpi/processor_perflib.c    |    2 +-
 drivers/acpi/processor_thermal.c    |    1 -
 drivers/acpi/processor_throttling.c |    2 +-
 drivers/acpi/thermal.c              |    1 -
 drivers/acpi/video.c                |    1 -
 include/acpi/acpi_drivers.h         |   13 ++++++++++++-
 16 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index d72a1b6..5cdd713 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -37,7 +37,6 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_AC_DEVICE_NAME		"AC Adapter"
 #define ACPI_AC_FILE_STATE		"state"
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 71d21c5..63a17b5 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -32,7 +32,6 @@
 #include <linux/memory_hotplug.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
 #define ACPI_MEMORY_DEVICE_CLASS		"memory"
 #define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
 #define ACPI_MEMORY_DEVICE_NAME			"Hotplug Mem Device"
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b2133e8..47f6e38 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -46,7 +46,6 @@
 
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
 
-#define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cb046c3..fd7ca28 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -33,7 +33,6 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_BUTTON_COMPONENT		0x00080000
 #define ACPI_BUTTON_CLASS		"button"
 #define ACPI_BUTTON_FILE_INFO		"info"
 #define ACPI_BUTTON_FILE_STATE		"state"
diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index 4441e84..077777c 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -34,7 +34,6 @@
 ACPI_MODULE_NAME("cm_sbs");
 #define ACPI_AC_CLASS		"ac_adapter"
 #define ACPI_BATTERY_CLASS	"battery"
-#define ACPI_SBS_COMPONENT	0x00080000
 #define _COMPONENT		ACPI_SBS_COMPONENT
 static struct proc_dir_entry *acpi_ac_dir;
 static struct proc_dir_entry *acpi_battery_dir;
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 134818b..17020c1 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -41,7 +41,6 @@
 #define INSTALL_NOTIFY_HANDLER		1
 #define UNINSTALL_NOTIFY_HANDLER	2
 
-#define ACPI_CONTAINER_COMPONENT	0x01000000
 #define _COMPONENT			ACPI_CONTAINER_COMPONENT
 ACPI_MODULE_NAME("container");
 
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 60d54d1..eaaee16 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -34,7 +34,6 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_FAN_CLASS			"fan"
 #define ACPI_FAN_FILE_STATE		"state"
 
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index a1718e5..81f583f 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -44,9 +44,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define _COMPONENT		ACPI_POWER_COMPONENT
+#define _COMPONENT			ACPI_POWER_COMPONENT
 ACPI_MODULE_NAME("power");
-#define ACPI_POWER_COMPONENT		0x00800000
 #define ACPI_POWER_CLASS		"power_resource"
 #define ACPI_POWER_DEVICE_NAME		"Power Resource"
 #define ACPI_POWER_FILE_INFO		"info"
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 24a362f..105e0ff 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -59,7 +59,6 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
 
-#define ACPI_PROCESSOR_COMPONENT	0x01000000
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
 #define ACPI_PROCESSOR_FILE_INFO	"info"
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 81b40ed..5f8d746 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -59,7 +59,6 @@
 #include <acpi/processor.h>
 #include <asm/processor.h>
 
-#define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index dbcf260..0d7b772 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -44,9 +44,9 @@
 #endif
 
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
 
-#define ACPI_PROCESSOR_COMPONENT	0x01000000
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index ef34b18..b1eb376 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -40,7 +40,6 @@
 #include <acpi/processor.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_thermal");
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 3da2df9..a0c38c9 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -38,9 +38,9 @@
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
 
-#define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index ad6cae9..a6da1d9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -47,7 +47,6 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_THERMAL_COMPONENT		0x04000000
 #define ACPI_THERMAL_CLASS		"thermal_zone"
 #define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
 #define ACPI_THERMAL_FILE_STATE		"state"
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index a29b0cc..0723f50 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -41,7 +41,6 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_VIDEO_COMPONENT		0x08000000
 #define ACPI_VIDEO_CLASS		"video"
 #define ACPI_VIDEO_BUS_NAME		"Video Bus"
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index cf04c60..ebf5420 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -32,7 +32,19 @@
 #define ACPI_MAX_STRING			80
 
 #define ACPI_BUS_COMPONENT		0x00010000
+#define ACPI_AC_COMPONENT		0x00020000
+#define ACPI_BATTERY_COMPONENT		0x00040000
+#define ACPI_BUTTON_COMPONENT		0x00080000
+#define ACPI_SBS_COMPONENT		0x00080000
+#define ACPI_FAN_COMPONENT		0x00200000
+#define ACPI_PCI_COMPONENT		0x00400000
+#define ACPI_POWER_COMPONENT		0x00800000
+#define ACPI_CONTAINER_COMPONENT	0x01000000
+#define ACPI_PROCESSOR_COMPONENT	0x01000000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
+#define ACPI_THERMAL_COMPONENT		0x04000000
+#define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
+#define ACPI_VIDEO_COMPONENT		0x08000000
 
 /*
  * _HID definitions
@@ -54,7 +66,6 @@
                                        PCI
    -------------------------------------------------------------------------- */
 
-#define ACPI_PCI_COMPONENT		0x00400000
 
 /* ACPI PCI Interrupt Link (pci_link.c) */
 

