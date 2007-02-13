From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/41] ACPI: clean up ACPI_MODULE_NAME() use
Date: Tue, 13 Feb 2007 00:49:39 -0500
Message-ID: <11713458271675-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org> <11713458233765-git-send-email-lenb@kernel.org> <11713458242872-git-send-email-lenb@kernel.org> <11713458251648-git-send-email-lenb@kernel.org> <11713458262743-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:19853 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075AbXBMFua (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:30 -0500
In-Reply-To: <11713458262743-git-send-email-lenb@kernel.org>
Message-Id: <f52fd66d2ea794010c2d7536cf8e6abed0ac4947.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

cosmetic only

Make "module name" actually match the file name.
Invoke with ';' as leaving it off confuses Lindent and gcc doesn't care.
Fix indentation where Lindent did get confused.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c                   |    4 ++--
 drivers/acpi/acpi_memhotplug.c      |    4 ++--
 drivers/acpi/battery.c              |    4 ++--
 drivers/acpi/bay.c                  |    2 +-
 drivers/acpi/bus.c                  |    2 +-
 drivers/acpi/button.c               |    2 +-
 drivers/acpi/cm_sbs.c               |    2 +-
 drivers/acpi/container.c            |    4 ++--
 drivers/acpi/debug.c                |    2 +-
 drivers/acpi/dock.c                 |    2 +-
 drivers/acpi/ec.c                   |    2 +-
 drivers/acpi/event.c                |    2 +-
 drivers/acpi/fan.c                  |    4 ++--
 drivers/acpi/i2c_ec.c               |    2 +-
 drivers/acpi/numa.c                 |    2 +-
 drivers/acpi/osl.c                  |    2 +-
 drivers/acpi/pci_bind.c             |    2 +-
 drivers/acpi/pci_irq.c              |    2 +-
 drivers/acpi/pci_link.c             |    2 +-
 drivers/acpi/pci_root.c             |    2 +-
 drivers/acpi/power.c                |    2 +-
 drivers/acpi/processor_core.c       |    4 ++--
 drivers/acpi/processor_idle.c       |    2 +-
 drivers/acpi/processor_perflib.c    |    2 +-
 drivers/acpi/processor_thermal.c    |    2 +-
 drivers/acpi/processor_throttling.c |    2 +-
 drivers/acpi/sbs.c                  |    2 +-
 drivers/acpi/scan.c                 |    2 +-
 drivers/acpi/system.c               |    2 +-
 drivers/acpi/thermal.c              |    2 +-
 drivers/acpi/utils.c                |    2 +-
 drivers/acpi/video.c                |    4 ++--
 32 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 6daeace..a9b30e6 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -44,9 +44,9 @@
 #define ACPI_AC_STATUS_UNKNOWN		0xFF
 
 #define _COMPONENT		ACPI_AC_COMPONENT
-ACPI_MODULE_NAME("acpi_ac")
+ACPI_MODULE_NAME("ac");
 
-    MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_AC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index cd946ed..88a6dc3 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -40,8 +40,8 @@
 
 #define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
 
-ACPI_MODULE_NAME("acpi_memory")
-    MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
+ACPI_MODULE_NAME("acpi_memhotplug");
+MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
 MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2f4521a..4b8db56 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -53,9 +53,9 @@
 #define ACPI_BATTERY_UNITS_AMPS		"mA"
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
-ACPI_MODULE_NAME("acpi_battery")
+ACPI_MODULE_NAME("battery");
 
-    MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_BATTERY_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 91082ce..19fe57d 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -34,7 +34,7 @@
 
 #define ACPI_BAY_DRIVER_NAME "ACPI Removable Drive Bay Driver"
 
-ACPI_MODULE_NAME("bay")
+ACPI_MODULE_NAME("bay");
 MODULE_AUTHOR("Kristen Carlson Accardi");
 MODULE_DESCRIPTION(ACPI_BAY_DRIVER_NAME);
 MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c26468d..fd37e19 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -39,7 +39,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
-ACPI_MODULE_NAME("acpi_bus")
+ACPI_MODULE_NAME("bus");
 #ifdef	CONFIG_X86
 extern void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger);
 #endif
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index c726612..28ce5c6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -61,7 +61,7 @@
 #define ACPI_BUTTON_TYPE_LID		0x05
 
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
-ACPI_MODULE_NAME("acpi_button")
+ACPI_MODULE_NAME("button");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_BUTTON_DRIVER_NAME);
diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index 4a9b7bf..f9db4f4 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -31,7 +31,7 @@
 #include <acpi/actypes.h>
 #include <acpi/acutils.h>
 
-ACPI_MODULE_NAME("cm_sbs")
+ACPI_MODULE_NAME("cm_sbs");
 #define ACPI_AC_CLASS		"ac_adapter"
 #define ACPI_BATTERY_CLASS	"battery"
 #define ACPI_SBS_COMPONENT	0x00080000
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 69a68fd..f3e59af 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -44,9 +44,9 @@
 
 #define ACPI_CONTAINER_COMPONENT	0x01000000
 #define _COMPONENT			ACPI_CONTAINER_COMPONENT
-ACPI_MODULE_NAME("acpi_container")
+ACPI_MODULE_NAME("container");
 
-    MODULE_AUTHOR("Anil S Keshavamurthy");
+MODULE_AUTHOR("Anil S Keshavamurthy");
 MODULE_DESCRIPTION(ACPI_CONTAINER_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index d48f65a..bf513e0 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -12,7 +12,7 @@
 #include <acpi/acglobal.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("debug")
+ACPI_MODULE_NAME("debug");
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 688e83a..b3a04ff 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -34,7 +34,7 @@
 
 #define ACPI_DOCK_DRIVER_NAME "ACPI Dock Station Driver"
 
-ACPI_MODULE_NAME("dock")
+ACPI_MODULE_NAME("dock");
 MODULE_AUTHOR("Kristen Carlson Accardi");
 MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_NAME);
 MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 743ce27..a5c0b5c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -38,7 +38,7 @@
 #include <acpi/actypes.h>
 
 #define _COMPONENT		ACPI_EC_COMPONENT
-ACPI_MODULE_NAME("acpi_ec")
+ACPI_MODULE_NAME("ec");
 #define ACPI_EC_COMPONENT		0x00100000
 #define ACPI_EC_CLASS			"embedded_controller"
 #define ACPI_EC_HID			"PNP0C09"
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 959a893..3b23562 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -13,7 +13,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("event")
+ACPI_MODULE_NAME("event");
 
 /* Global vars for handling event proc entry */
 static DEFINE_SPINLOCK(acpi_system_event_lock);
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index af22fdf..b902d3b 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -40,9 +40,9 @@
 #define ACPI_FAN_FILE_STATE		"state"
 
 #define _COMPONENT		ACPI_FAN_COMPONENT
-ACPI_MODULE_NAME("acpi_fan")
+ACPI_MODULE_NAME("fan");
 
-    MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_FAN_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/acpi/i2c_ec.c b/drivers/acpi/i2c_ec.c
index 8338be0..62af6da 100644
--- a/drivers/acpi/i2c_ec.c
+++ b/drivers/acpi/i2c_ec.c
@@ -33,7 +33,7 @@
 
 #define _COMPONENT		ACPI_EC_HC_COMPONENT
 
-ACPI_MODULE_NAME("acpi_smbus")
+ACPI_MODULE_NAME("i2c_ec");
 
 static int acpi_ec_hc_add(struct acpi_device *device);
 static int acpi_ec_hc_remove(struct acpi_device *device, int type);
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 4a9faff..dcd58a4 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -33,7 +33,7 @@
 
 #define ACPI_NUMA	0x80000000
 #define _COMPONENT	ACPI_NUMA
-ACPI_MODULE_NAME("numa")
+ACPI_MODULE_NAME("numa");
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 #define PXM_INVAL	-1
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 0f6f3bc..851ac49 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -46,7 +46,7 @@
 #include <linux/efi.h>
 
 #define _COMPONENT		ACPI_OS_SERVICES
-ACPI_MODULE_NAME("osl")
+ACPI_MODULE_NAME("osl");
 #define PREFIX		"ACPI: "
 struct acpi_os_dpc {
 	acpi_osd_exec_callback function;
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 55f57a6..0289693 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -36,7 +36,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_bind")
+ACPI_MODULE_NAME("pci_bind");
 
 struct acpi_pci_data {
 	struct acpi_pci_id id;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index fe7d007..dd3186a 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -38,7 +38,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_irq")
+ACPI_MODULE_NAME("pci_irq");
 
 static struct acpi_prt_list acpi_prt;
 static DEFINE_SPINLOCK(acpi_prt_lock);
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 0f683c8..da22c5e 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -44,7 +44,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_link")
+ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
 #define ACPI_PCI_LINK_HID		"PNP0C0F"
 #define ACPI_PCI_LINK_DRIVER_NAME	"ACPI PCI Interrupt Link Driver"
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4ecf701..3db2cd3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -36,7 +36,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_root")
+ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
 #define ACPI_PCI_ROOT_HID		"PNP0A03"
 #define ACPI_PCI_ROOT_DRIVER_NAME	"ACPI PCI Root Bridge Driver"
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 0ba7dfb..26e8edc 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -45,7 +45,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_POWER_COMPONENT
-ACPI_MODULE_NAME("acpi_power")
+ACPI_MODULE_NAME("power");
 #define ACPI_POWER_COMPONENT		0x00800000
 #define ACPI_POWER_CLASS		"power_resource"
 #define ACPI_POWER_DRIVER_NAME		"ACPI Power Resource Driver"
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 0079bc5..13135f8 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -74,9 +74,9 @@
 #define ACPI_STA_PRESENT 0x00000001
 
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("acpi_processor")
+ACPI_MODULE_NAME("processor_core");
 
-    MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_PROCESSOR_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6c6751b..a26433d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -50,7 +50,7 @@
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define ACPI_PROCESSOR_DRIVER_NAME      "ACPI Processor Driver"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("acpi_processor")
+ACPI_MODULE_NAME("processor_idle");
 #define ACPI_PROCESSOR_FILE_POWER	"power"
 #define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
 #define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 058f13c..c2add4e 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -47,7 +47,7 @@
 #define ACPI_PROCESSOR_DRIVER_NAME	"ACPI Processor Driver"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("acpi_processor")
+ACPI_MODULE_NAME("processor_perflib");
 
 static DEFINE_MUTEX(performance_mutex);
 
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 40fecd6..9357d63 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -43,7 +43,7 @@
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define ACPI_PROCESSOR_DRIVER_NAME      "ACPI Processor Driver"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("acpi_processor")
+ACPI_MODULE_NAME("processor_thermal");
 
 /* --------------------------------------------------------------------------
                                  Limit Interface
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 89dff36..8194eb0 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -43,7 +43,7 @@
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define ACPI_PROCESSOR_DRIVER_NAME      "ACPI Processor Driver"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("acpi_processor")
+ACPI_MODULE_NAME("processor_throttling");
 
 /* --------------------------------------------------------------------------
                               Throttling Control
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f58fc74..f5b714d 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -78,7 +78,7 @@ extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 #define	MAX_SBS_BAT			4
 #define	MAX_SMBUS_ERR			1
 
-ACPI_MODULE_NAME("acpi_sbs");
+ACPI_MODULE_NAME("sbs");
 
 MODULE_AUTHOR("Rich Townsend");
 MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 64f26db..cff1b59 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,7 +11,7 @@
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
-ACPI_MODULE_NAME("scan")
+ACPI_MODULE_NAME("scan");
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 extern struct acpi_device *acpi_root;
 
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 7147b0b..edead9e 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -31,7 +31,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("acpi_system")
+ACPI_MODULE_NAME("system");
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f76d316..bf0a9f2 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -70,7 +70,7 @@
 #define CELSIUS_TO_KELVIN(t)	((t+273)*10)
 
 #define _COMPONENT		ACPI_THERMAL_COMPONENT
-ACPI_MODULE_NAME("acpi_thermal")
+ACPI_MODULE_NAME("thermal");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_THERMAL_DRIVER_NAME);
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 68a809f..34f1575 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -31,7 +31,7 @@
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
-ACPI_MODULE_NAME("acpi_utils")
+ACPI_MODULE_NAME("utils");
 
 /* --------------------------------------------------------------------------
                             Object Evaluation Helpers
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index e0b97ad..a095d01 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -65,9 +65,9 @@
 #define ACPI_VIDEO_DISPLAY_LCD	4
 
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
-ACPI_MODULE_NAME("acpi_video")
+ACPI_MODULE_NAME("video");
 
-    MODULE_AUTHOR("Bruno Ducrot");
+MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION(ACPI_VIDEO_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-- 
1.5.0.rc4.345.gb4d2
