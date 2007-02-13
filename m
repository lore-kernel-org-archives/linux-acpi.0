From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/41] ACPI: delete extra #defines in /drivers/acpi/ drivers
Date: Tue, 13 Feb 2007 00:49:41 -0500
Message-ID: <11713458283253-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org> <11713458233765-git-send-email-lenb@kernel.org> <11713458242872-git-send-email-lenb@kernel.org> <11713458251648-git-send-email-lenb@kernel.org> <11713458262743-git-send-email-lenb@kernel.org> <11713458271675-
 git-send-email-lenb@kernel.org> <11713458271642-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:17992 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751098AbXBMFua (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:30 -0500
In-Reply-To: <11713458271642-git-send-email-lenb@kernel.org>
Message-Id: <7cda93e008e1a477970adbf82dba81a5d4f0ae40.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Cosmetic only.

Except in a single case, #define ACPI_*_DRIVER_NAME
were invoked 0 or 1 times.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c                   |    3 +--
 drivers/acpi/acpi_memhotplug.c      |    3 +--
 drivers/acpi/battery.c              |    3 +--
 drivers/acpi/bay.c                  |    4 +---
 drivers/acpi/button.c               |    3 +--
 drivers/acpi/container.c            |    3 +--
 drivers/acpi/dock.c                 |    6 +++---
 drivers/acpi/ec.c                   |    1 -
 drivers/acpi/fan.c                  |    3 +--
 drivers/acpi/i2c_ec.c               |    1 -
 drivers/acpi/pci_link.c             |    1 -
 drivers/acpi/pci_root.c             |    1 -
 drivers/acpi/power.c                |    1 -
 drivers/acpi/processor_core.c       |    3 +--
 drivers/acpi/processor_idle.c       |    1 -
 drivers/acpi/processor_perflib.c    |    1 -
 drivers/acpi/processor_thermal.c    |    1 -
 drivers/acpi/processor_throttling.c |    1 -
 drivers/acpi/sbs.c                  |    1 -
 drivers/acpi/scan.c                 |    1 -
 drivers/acpi/system.c               |    1 -
 drivers/acpi/thermal.c              |    3 +--
 drivers/acpi/video.c                |    3 +--
 23 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 17eef27..37c7dc4 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -35,7 +35,6 @@
 #define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_AC_HID 			"ACPI0003"
-#define ACPI_AC_DRIVER_NAME		"ACPI AC Adapter Driver"
 #define ACPI_AC_DEVICE_NAME		"AC Adapter"
 #define ACPI_AC_FILE_STATE		"state"
 #define ACPI_AC_NOTIFY_STATUS		0x80
@@ -47,7 +46,7 @@
 ACPI_MODULE_NAME("ac");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION(ACPI_AC_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
 extern struct proc_dir_entry *acpi_lock_ac_dir(void);
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index d677130..c261726 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -35,14 +35,13 @@
 #define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
 #define ACPI_MEMORY_DEVICE_CLASS		"memory"
 #define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
-#define ACPI_MEMORY_DEVICE_DRIVER_NAME		"Hotplug Mem Driver"
 #define ACPI_MEMORY_DEVICE_NAME			"Hotplug Mem Device"
 
 #define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
 
 ACPI_MODULE_NAME("acpi_memhotplug");
 MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
-MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
+MODULE_DESCRIPTION("Hotplug Mem Driver");
 MODULE_LICENSE("GPL");
 
 /* ACPI _STA method values */
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index da29d9d..02de49e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -42,7 +42,6 @@
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_BATTERY_HID		"PNP0C0A"
-#define ACPI_BATTERY_DRIVER_NAME	"ACPI Battery Driver"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_FILE_INFO		"info"
 #define ACPI_BATTERY_FILE_STATUS	"state"
@@ -56,7 +55,7 @@
 ACPI_MODULE_NAME("battery");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION(ACPI_BATTERY_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 1f88858..36dcb89 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -32,11 +32,9 @@
 #include <asm/uaccess.h>
 #include <linux/platform_device.h>
 
-#define ACPI_BAY_DRIVER_NAME "ACPI Removable Drive Bay Driver"
-
 ACPI_MODULE_NAME("bay");
 MODULE_AUTHOR("Kristen Carlson Accardi");
-MODULE_DESCRIPTION(ACPI_BAY_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI Removable Drive Bay Driver");
 MODULE_LICENSE("GPL");
 #define ACPI_BAY_CLASS "bay"
 #define ACPI_BAY_COMPONENT	0x10000000
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 45f960d..cb4110b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -34,7 +34,6 @@
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_BUTTON_COMPONENT		0x00080000
-#define ACPI_BUTTON_DRIVER_NAME		"ACPI Button Driver"
 #define ACPI_BUTTON_CLASS		"button"
 #define ACPI_BUTTON_FILE_INFO		"info"
 #define ACPI_BUTTON_FILE_STATE		"state"
@@ -64,7 +63,7 @@
 ACPI_MODULE_NAME("button");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION(ACPI_BUTTON_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI Button Driver");
 MODULE_LICENSE("GPL");
 
 static int acpi_button_add(struct acpi_device *device);
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 0e36062..0930d94 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -35,7 +35,6 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/container.h>
 
-#define ACPI_CONTAINER_DRIVER_NAME	"ACPI container driver"
 #define ACPI_CONTAINER_DEVICE_NAME	"ACPI container device"
 #define ACPI_CONTAINER_CLASS		"container"
 
@@ -47,7 +46,7 @@
 ACPI_MODULE_NAME("container");
 
 MODULE_AUTHOR("Anil S Keshavamurthy");
-MODULE_DESCRIPTION(ACPI_CONTAINER_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI container driver");
 MODULE_LICENSE("GPL");
 
 #define ACPI_STA_PRESENT		(0x00000001)
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index b3a04ff..54a697f 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -32,11 +32,11 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_DOCK_DRIVER_NAME "ACPI Dock Station Driver"
+#define ACPI_DOCK_DRIVER_DESCRIPTION "ACPI Dock Station Driver"
 
 ACPI_MODULE_NAME("dock");
 MODULE_AUTHOR("Kristen Carlson Accardi");
-MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_NAME);
+MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 
 static struct atomic_notifier_head dock_notifier_list;
@@ -741,7 +741,7 @@ static int dock_add(acpi_handle handle)
 		goto dock_add_err;
 	}
 
-	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_NAME);
+	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_DESCRIPTION);
 
 	return 0;
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9d67952..c1f6251 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -42,7 +42,6 @@ ACPI_MODULE_NAME("ec");
 #define ACPI_EC_COMPONENT		0x00100000
 #define ACPI_EC_CLASS			"embedded_controller"
 #define ACPI_EC_HID			"PNP0C09"
-#define ACPI_EC_DRIVER_NAME		"ACPI Embedded Controller Driver"
 #define ACPI_EC_DEVICE_NAME		"Embedded Controller"
 #define ACPI_EC_FILE_INFO		"info"
 #undef PREFIX
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 5ac727e..ec655c5 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -36,14 +36,13 @@
 
 #define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_FAN_CLASS			"fan"
-#define ACPI_FAN_DRIVER_NAME		"ACPI Fan Driver"
 #define ACPI_FAN_FILE_STATE		"state"
 
 #define _COMPONENT		ACPI_FAN_COMPONENT
 ACPI_MODULE_NAME("fan");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION(ACPI_FAN_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI Fan Driver");
 MODULE_LICENSE("GPL");
 
 static int acpi_fan_add(struct acpi_device *device);
diff --git a/drivers/acpi/i2c_ec.c b/drivers/acpi/i2c_ec.c
index d2fde7a..a29b827 100644
--- a/drivers/acpi/i2c_ec.c
+++ b/drivers/acpi/i2c_ec.c
@@ -28,7 +28,6 @@
 #define ACPI_EC_HC_COMPONENT	0x00080000
 #define ACPI_EC_HC_CLASS	"ec_hc_smbus"
 #define ACPI_EC_HC_HID		"ACPI0001"
-#define ACPI_EC_HC_DRIVER_NAME	"ACPI EC HC smbus driver"
 #define ACPI_EC_HC_DEVICE_NAME	"EC HC smbus"
 
 #define _COMPONENT		ACPI_EC_HC_COMPONENT
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index a95f03f..acc5947 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -47,7 +47,6 @@
 ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
 #define ACPI_PCI_LINK_HID		"PNP0C0F"
-#define ACPI_PCI_LINK_DRIVER_NAME	"ACPI PCI Interrupt Link Driver"
 #define ACPI_PCI_LINK_DEVICE_NAME	"PCI Interrupt Link"
 #define ACPI_PCI_LINK_FILE_INFO		"info"
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7bf24c3..ad4145a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -39,7 +39,6 @@
 ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
 #define ACPI_PCI_ROOT_HID		"PNP0A03"
-#define ACPI_PCI_ROOT_DRIVER_NAME	"ACPI PCI Root Bridge Driver"
 #define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
 static int acpi_pci_root_add(struct acpi_device *device);
 static int acpi_pci_root_remove(struct acpi_device *device, int type);
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 09b855d..92f80ba 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -48,7 +48,6 @@
 ACPI_MODULE_NAME("power");
 #define ACPI_POWER_COMPONENT		0x00800000
 #define ACPI_POWER_CLASS		"power_resource"
-#define ACPI_POWER_DRIVER_NAME		"ACPI Power Resource Driver"
 #define ACPI_POWER_DEVICE_NAME		"Power Resource"
 #define ACPI_POWER_FILE_INFO		"info"
 #define ACPI_POWER_FILE_STATUS		"state"
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 19c44b5..911fc8c 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -60,7 +60,6 @@
 
 #define ACPI_PROCESSOR_COMPONENT	0x01000000
 #define ACPI_PROCESSOR_CLASS		"processor"
-#define ACPI_PROCESSOR_DRIVER_NAME	"ACPI Processor Driver"
 #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
 #define ACPI_PROCESSOR_FILE_INFO	"info"
 #define ACPI_PROCESSOR_FILE_THROTTLING	"throttling"
@@ -77,7 +76,7 @@
 ACPI_MODULE_NAME("processor_core");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION(ACPI_PROCESSOR_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
 static int acpi_processor_add(struct acpi_device *device);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index a26433d..92f5185 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -48,7 +48,6 @@
 
 #define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
-#define ACPI_PROCESSOR_DRIVER_NAME      "ACPI Processor Driver"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
 #define ACPI_PROCESSOR_FILE_POWER	"power"
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index c2add4e..2f2e796 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -44,7 +44,6 @@
 
 #define ACPI_PROCESSOR_COMPONENT	0x01000000
 #define ACPI_PROCESSOR_CLASS		"processor"
-#define ACPI_PROCESSOR_DRIVER_NAME	"ACPI Processor Driver"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_perflib");
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 9357d63..06e6f3f 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -41,7 +41,6 @@
 
 #define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
-#define ACPI_PROCESSOR_DRIVER_NAME      "ACPI Processor Driver"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_thermal");
 
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 8194eb0..b334860 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -41,7 +41,6 @@
 
 #define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
-#define ACPI_PROCESSOR_DRIVER_NAME      "ACPI Processor Driver"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 1c2d8fb..1eab203 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -59,7 +59,6 @@ extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_SBS_HID			"ACPI0002"
-#define ACPI_SBS_DRIVER_NAME		"ACPI Smart Battery System Driver"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
 #define ACPI_SBS_FILE_INFO		"info"
 #define ACPI_SBS_FILE_STATE		"state"
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index cff1b59..bb0e0da 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -17,7 +17,6 @@ extern struct acpi_device *acpi_root;
 
 #define ACPI_BUS_CLASS			"system_bus"
 #define ACPI_BUS_HID			"ACPI_BUS"
-#define ACPI_BUS_DRIVER_NAME		"ACPI Bus Driver"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
 static LIST_HEAD(acpi_device_list);
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index edead9e..83a8d30 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -38,7 +38,6 @@ ACPI_MODULE_NAME("system");
 #define MODULE_PARAM_PREFIX "acpi."
 
 #define ACPI_SYSTEM_CLASS		"system"
-#define ACPI_SYSTEM_DRIVER_NAME		"ACPI System Driver"
 #define ACPI_SYSTEM_DEVICE_NAME		"System"
 #define ACPI_SYSTEM_FILE_INFO		"info"
 #define ACPI_SYSTEM_FILE_EVENT		"event"
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c34a89d..f50a405 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -46,7 +46,6 @@
 
 #define ACPI_THERMAL_COMPONENT		0x04000000
 #define ACPI_THERMAL_CLASS		"thermal_zone"
-#define ACPI_THERMAL_DRIVER_NAME	"ACPI Thermal Zone Driver"
 #define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
 #define ACPI_THERMAL_FILE_STATE		"state"
 #define ACPI_THERMAL_FILE_TEMPERATURE	"temperature"
@@ -73,7 +72,7 @@
 ACPI_MODULE_NAME("thermal");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION(ACPI_THERMAL_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
 MODULE_LICENSE("GPL");
 
 static int tzp;
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 0c44ffd..bf525cc 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -40,7 +40,6 @@
 
 #define ACPI_VIDEO_COMPONENT		0x08000000
 #define ACPI_VIDEO_CLASS		"video"
-#define ACPI_VIDEO_DRIVER_NAME		"ACPI Video Driver"
 #define ACPI_VIDEO_BUS_NAME		"Video Bus"
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
 #define ACPI_VIDEO_NOTIFY_SWITCH	0x80
@@ -68,7 +67,7 @@
 ACPI_MODULE_NAME("video");
 
 MODULE_AUTHOR("Bruno Ducrot");
-MODULE_DESCRIPTION(ACPI_VIDEO_DRIVER_NAME);
+MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
 static int acpi_video_bus_add(struct acpi_device *device);
-- 
1.5.0.rc4.345.gb4d2
