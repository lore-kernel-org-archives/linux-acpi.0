From: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/16] ACPI: autoload modules - Create __mod_acpi_device_table symbol for all ACPI drivers
Date: Wed, 25 Jul 2007 01:51:19 -0400
Message-ID: <11853426964149-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5266 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbXGYFvl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:41 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <1ba90e3a87c46500623afdc3898573e4a5ebb21b.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

modpost is going to use these to create e.g. acpi:ACPI0001
in modules.alias.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c               |    9 +++++++--
 drivers/acpi/acpi_memhotplug.c  |    8 +++++++-
 drivers/acpi/asus_acpi.c        |   11 ++++++++---
 drivers/acpi/battery.c          |    9 +++++++--
 drivers/acpi/button.c           |   12 +++++++++++-
 drivers/acpi/container.c        |   10 +++++++++-
 drivers/acpi/ec.c               |    8 ++++++--
 drivers/acpi/fan.c              |    8 +++++++-
 drivers/acpi/pci_link.c         |    9 +++++++--
 drivers/acpi/pci_root.c         |    9 +++++++--
 drivers/acpi/power.c            |    8 +++++++-
 drivers/acpi/processor_core.c   |    8 +++++++-
 drivers/acpi/sbs.c              |   10 ++++++++--
 drivers/acpi/thermal.c          |    8 +++++++-
 drivers/acpi/video.c            |    8 +++++++-
 drivers/char/hpet.c             |    8 +++++++-
 drivers/input/misc/atlas_btns.c |    9 +++++++--
 drivers/misc/asus-laptop.c      |    9 +++++++--
 drivers/misc/sony-laptop.c      |   21 +++++++++++++++++++--
 drivers/misc/thinkpad_acpi.c    |   20 ++++++++++++++++----
 drivers/misc/thinkpad_acpi.h    |    2 +-
 21 files changed, 169 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 37c7dc4..d8b3509 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -34,7 +34,6 @@
 
 #define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_AC_CLASS			"ac_adapter"
-#define ACPI_AC_HID 			"ACPI0003"
 #define ACPI_AC_DEVICE_NAME		"AC Adapter"
 #define ACPI_AC_FILE_STATE		"state"
 #define ACPI_AC_NOTIFY_STATUS		0x80
@@ -56,10 +55,16 @@ static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device, int type);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
+const static struct acpi_device_id ac_device_ids[] = {
+	{"ACPI0003", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, ac_device_ids);
+
 static struct acpi_driver acpi_ac_driver = {
 	.name = "ac",
 	.class = ACPI_AC_CLASS,
-	.ids = ACPI_AC_HID,
+	.ids = ac_device_ids,
 	.ops = {
 		.add = acpi_ac_add,
 		.remove = acpi_ac_remove,
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index e65628a..5f1127a 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -53,10 +53,16 @@ static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
 static int acpi_memory_device_start(struct acpi_device *device);
 
+static const struct acpi_device_id memory_device_ids[] = {
+	{ACPI_MEMORY_DEVICE_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, memory_device_ids);
+
 static struct acpi_driver acpi_memory_device_driver = {
 	.name = "acpi_memhotplug",
 	.class = ACPI_MEMORY_DEVICE_CLASS,
-	.ids = ACPI_MEMORY_DEVICE_HID,
+	.ids = memory_device_ids,
 	.ops = {
 		.add = acpi_memory_device_add,
 		.remove = acpi_memory_device_remove,
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 3cd79ca..9c4bd22 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -56,7 +56,6 @@
 #define ACPI_HOTK_NAME          "Asus Laptop ACPI Extras Driver"
 #define ACPI_HOTK_CLASS         "hotkey"
 #define ACPI_HOTK_DEVICE_NAME   "Hotkey"
-#define ACPI_HOTK_HID           "ATK0100"
 
 /*
  * Some events we use, same for all Asus
@@ -426,14 +425,20 @@ static struct acpi_table_header *asus_info;
 static struct asus_hotk *hotk;
 
 /*
- * The hotkey driver declaration
+ * The hotkey driver and autoloading declaration
  */
 static int asus_hotk_add(struct acpi_device *device);
 static int asus_hotk_remove(struct acpi_device *device, int type);
+static const struct acpi_device_id asus_device_ids[] = {
+	{"ATK0100", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, asus_device_ids);
+
 static struct acpi_driver asus_hotk_driver = {
 	.name = "asus_acpi",
 	.class = ACPI_HOTK_CLASS,
-	.ids = ACPI_HOTK_HID,
+	.ids = asus_device_ids,
 	.ops = {
 		.add = asus_hotk_add,
 		.remove = asus_hotk_remove,
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cad932d..8165103 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -41,7 +41,6 @@
 
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BATTERY_CLASS		"battery"
-#define ACPI_BATTERY_HID		"PNP0C0A"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
@@ -74,10 +73,16 @@ static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
 static int acpi_battery_resume(struct acpi_device *device);
 
+static const struct acpi_device_id battery_device_ids[] = {
+	{"PNP0C0A", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, battery_device_ids);
+
 static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
 	.class = ACPI_BATTERY_CLASS,
-	.ids = ACPI_BATTERY_HID,
+	.ids = battery_device_ids,
 	.ops = {
 		.add = acpi_battery_add,
 		.resume = acpi_battery_resume,
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cb4110b..5405813 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -66,6 +66,16 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Button Driver");
 MODULE_LICENSE("GPL");
 
+static const struct acpi_device_id button_device_ids[] = {
+	{ACPI_BUTTON_HID_LID,    0},
+	{ACPI_BUTTON_HID_SLEEP,  0},
+	{ACPI_BUTTON_HID_SLEEPF, 0},
+	{ACPI_BUTTON_HID_POWER,  0},
+	{ACPI_BUTTON_HID_POWERF, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, button_device_ids);
+
 static int acpi_button_add(struct acpi_device *device);
 static int acpi_button_remove(struct acpi_device *device, int type);
 static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
@@ -74,7 +84,7 @@ static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
 static struct acpi_driver acpi_button_driver = {
 	.name = "button",
 	.class = ACPI_BUTTON_CLASS,
-	.ids = "button_power,button_sleep,PNP0C0D,PNP0C0C,PNP0C0E",
+	.ids = button_device_ids,
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 0dd3bf7..3c25ec7 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -52,10 +52,18 @@ MODULE_LICENSE("GPL");
 static int acpi_container_add(struct acpi_device *device);
 static int acpi_container_remove(struct acpi_device *device, int type);
 
+static const struct acpi_device_id container_device_ids[] = {
+	{"ACPI0004", 0},
+	{"PNP0A05", 0},
+	{"PNP0A06", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, container_device_ids);
+
 static struct acpi_driver acpi_container_driver = {
 	.name = "container",
 	.class = ACPI_CONTAINER_CLASS,
-	.ids = "ACPI0004,PNP0A05,PNP0A06",
+	.ids = container_device_ids,
 	.ops = {
 		.add = acpi_container_add,
 		.remove = acpi_container_remove,
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 10e8510..469f3f5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -41,7 +41,6 @@
 #include <acpi/actypes.h>
 
 #define ACPI_EC_CLASS			"embedded_controller"
-#define ACPI_EC_HID			"PNP0C09"
 #define ACPI_EC_DEVICE_NAME		"Embedded Controller"
 #define ACPI_EC_FILE_INFO		"info"
 
@@ -82,10 +81,15 @@ static int acpi_ec_start(struct acpi_device *device);
 static int acpi_ec_stop(struct acpi_device *device, int type);
 static int acpi_ec_add(struct acpi_device *device);
 
+static const struct acpi_device_id ec_device_ids[] = {
+	{"PNP0C09", 0},
+	{"", 0},
+};
+
 static struct acpi_driver acpi_ec_driver = {
 	.name = "ec",
 	.class = ACPI_EC_CLASS,
-	.ids = ACPI_EC_HID,
+	.ids = ec_device_ids,
 	.ops = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index ec655c5..c81f6bd 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -50,10 +50,16 @@ static int acpi_fan_remove(struct acpi_device *device, int type);
 static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state);
 static int acpi_fan_resume(struct acpi_device *device);
 
+static const struct acpi_device_id fan_device_ids[] = {
+	{"PNP0C0B", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, fan_device_ids);
+
 static struct acpi_driver acpi_fan_driver = {
 	.name = "fan",
 	.class = ACPI_FAN_CLASS,
-	.ids = "PNP0C0B",
+	.ids = fan_device_ids,
 	.ops = {
 		.add = acpi_fan_add,
 		.remove = acpi_fan_remove,
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 3448edd..c9f526e 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -46,7 +46,6 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
-#define ACPI_PCI_LINK_HID		"PNP0C0F"
 #define ACPI_PCI_LINK_DEVICE_NAME	"PCI Interrupt Link"
 #define ACPI_PCI_LINK_FILE_INFO		"info"
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
@@ -54,10 +53,16 @@ ACPI_MODULE_NAME("pci_link");
 static int acpi_pci_link_add(struct acpi_device *device);
 static int acpi_pci_link_remove(struct acpi_device *device, int type);
 
+static struct acpi_device_id link_device_ids[] = {
+	{"PNP0C0F", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, link_device_ids);
+
 static struct acpi_driver acpi_pci_link_driver = {
 	.name = "pci_link",
 	.class = ACPI_PCI_LINK_CLASS,
-	.ids = ACPI_PCI_LINK_HID,
+	.ids = link_device_ids,
 	.ops = {
 		.add = acpi_pci_link_add,
 		.remove = acpi_pci_link_remove,
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ad4145a..f14ff1f 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -38,16 +38,21 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
-#define ACPI_PCI_ROOT_HID		"PNP0A03"
 #define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
 static int acpi_pci_root_add(struct acpi_device *device);
 static int acpi_pci_root_remove(struct acpi_device *device, int type);
 static int acpi_pci_root_start(struct acpi_device *device);
 
+static struct acpi_device_id root_device_ids[] = {
+	{"PNP0A03", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, root_device_ids);
+
 static struct acpi_driver acpi_pci_root_driver = {
 	.name = "pci_root",
 	.class = ACPI_PCI_ROOT_CLASS,
-	.ids = ACPI_PCI_ROOT_HID,
+	.ids = root_device_ids,
 	.ops = {
 		.add = acpi_pci_root_add,
 		.remove = acpi_pci_root_remove,
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4ffecd1..57b9a29 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -59,10 +59,16 @@ static int acpi_power_remove(struct acpi_device *device, int type);
 static int acpi_power_resume(struct acpi_device *device);
 static int acpi_power_open_fs(struct inode *inode, struct file *file);
 
+static struct acpi_device_id power_device_ids[] = {
+	{ACPI_POWER_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, power_device_ids);
+
 static struct acpi_driver acpi_power_driver = {
 	.name = "power",
 	.class = ACPI_POWER_CLASS,
-	.ids = ACPI_POWER_HID,
+	.ids = power_device_ids,
 	.ops = {
 		.add = acpi_power_add,
 		.remove = acpi_power_remove,
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 81aceb5..4984223 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -88,10 +88,16 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr);
 extern int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 
 
+static const struct acpi_device_id processor_device_ids[] = {
+	{ACPI_PROCESSOR_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, processor_device_ids);
+
 static struct acpi_driver acpi_processor_driver = {
 	.name = "processor",
 	.class = ACPI_PROCESSOR_CLASS,
-	.ids = ACPI_PROCESSOR_HID,
+	.ids = processor_device_ids,
 	.ops = {
 		.add = acpi_processor_add,
 		.remove = acpi_processor_remove,
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 974d00c..7d8e78e 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -38,7 +38,6 @@
 #define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_BATTERY_CLASS		"battery"
-#define ACPI_SBS_HID			"ACPI0002"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
 #define ACPI_SBS_FILE_INFO		"info"
 #define ACPI_SBS_FILE_STATE		"state"
@@ -124,10 +123,17 @@ static int acpi_sbs_add(struct acpi_device *device);
 static int acpi_sbs_remove(struct acpi_device *device, int type);
 static int acpi_sbs_resume(struct acpi_device *device);
 
+static const struct acpi_device_id sbs_device_ids[] = {
+	{"ACPI0001", 0},
+	{"ACPI0005", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
+
 static struct acpi_driver acpi_sbs_driver = {
 	.name = "sbs",
 	.class = ACPI_SBS_CLASS,
-	.ids = "ACPI0001,ACPI0005",
+	.ids = sbs_device_ids,
 	.ops = {
 		.add = acpi_sbs_add,
 		.remove = acpi_sbs_remove,
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 58f1338..5a62de1 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -92,10 +92,16 @@ static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file);
 static ssize_t acpi_thermal_write_polling(struct file *, const char __user *,
 					  size_t, loff_t *);
 
+static const struct acpi_device_id  thermal_device_ids[] = {
+	{ACPI_THERMAL_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
+
 static struct acpi_driver acpi_thermal_driver = {
 	.name = "thermal",
 	.class = ACPI_THERMAL_CLASS,
-	.ids = ACPI_THERMAL_HID,
+	.ids = thermal_device_ids,
 	.ops = {
 		.add = acpi_thermal_add,
 		.remove = acpi_thermal_remove,
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 04ea697..d987019 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -74,10 +74,16 @@ MODULE_LICENSE("GPL");
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 
+static const struct acpi_device_id video_device_ids[] = {
+	{ACPI_VIDEO_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, video_device_ids);
+
 static struct acpi_driver acpi_video_bus = {
 	.name = "video",
 	.class = ACPI_VIDEO_CLASS,
-	.ids = ACPI_VIDEO_HID,
+	.ids = video_device_ids,
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ba0e74a..9a2694e 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -1007,9 +1007,15 @@ static int hpet_acpi_remove(struct acpi_device *device, int type)
 	return -EINVAL;
 }
 
+static const struct acpi_device_id hpet_device_ids[] = {
+	{"PNP0103", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, hpet_device_ids);
+
 static struct acpi_driver hpet_acpi_driver = {
 	.name = "hpet",
-	.ids = "PNP0103",
+	.ids = hpet_device_ids,
 	.ops = {
 		.add = hpet_acpi_add,
 		.remove = hpet_acpi_remove,
diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 0acc3a1..e43e92f 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -31,7 +31,6 @@
 
 #define ACPI_ATLAS_NAME			"Atlas ACPI"
 #define ACPI_ATLAS_CLASS		"Atlas"
-#define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
 
 static struct input_dev *input_dev;
 
@@ -130,10 +129,16 @@ static int atlas_acpi_button_remove(struct acpi_device *device, int type)
 	return status;
 }
 
+static const struct acpi_device_id atlas_device_ids[] = {
+	{"ASIM0000", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
+
 static struct acpi_driver atlas_acpi_driver = {
 	.name	= ACPI_ATLAS_NAME,
 	.class	= ACPI_ATLAS_CLASS,
-	.ids	= ACPI_ATLAS_BUTTON_HID,
+	.ids	= atlas_device_ids,
 	.ops	= {
 		.add	= atlas_acpi_button_add,
 		.remove	= atlas_acpi_button_remove,
diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index f753060..63953fe 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -53,7 +53,6 @@
 #define ASUS_HOTK_NAME          "Asus Laptop Support"
 #define ASUS_HOTK_CLASS         "hotkey"
 #define ASUS_HOTK_DEVICE_NAME   "Hotkey"
-#define ASUS_HOTK_HID           "ATK0100"
 #define ASUS_HOTK_FILE          "asus-laptop"
 #define ASUS_HOTK_PREFIX        "\\_SB.ATKD."
 
@@ -197,12 +196,18 @@ static struct asus_hotk *hotk;
 /*
  * The hotkey driver declaration
  */
+static const struct acpi_device_id asus_device_ids[] = {
+	{"ATK0100", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, asus_device_ids);
+
 static int asus_hotk_add(struct acpi_device *device);
 static int asus_hotk_remove(struct acpi_device *device, int type);
 static struct acpi_driver asus_hotk_driver = {
 	.name = ASUS_HOTK_NAME,
 	.class = ASUS_HOTK_CLASS,
-	.ids = ASUS_HOTK_HID,
+	.ids = asus_device_ids,
 	.ops = {
 		.add = asus_hotk_add,
 		.remove = asus_hotk_remove,
diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 303e48c..14ee06c 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1124,10 +1124,22 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static const struct acpi_device_id sony_device_ids[] = {
+	{SONY_NC_HID, 0},
+	{SONY_PIC_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, sony_device_ids);
+
+static const struct acpi_device_id sony_nc_device_ids[] = {
+	{SONY_NC_HID, 0},
+	{"", 0},
+};
+
 static struct acpi_driver sony_nc_driver = {
 	.name = SONY_NC_DRIVER_NAME,
 	.class = SONY_NC_CLASS,
-	.ids = SONY_NC_HID,
+	.ids = sony_nc_device_ids,
 	.owner = THIS_MODULE,
 	.ops = {
 		.add = sony_nc_add,
@@ -2470,10 +2482,15 @@ static int sony_pic_resume(struct acpi_device *device)
 	return 0;
 }
 
+static const struct acpi_device_id sony_pic_device_ids[] = {
+	{SONY_PIC_HID, 0},
+	{"", 0},
+};
+
 static struct acpi_driver sony_pic_driver = {
 	.name = SONY_PIC_DRIVER_NAME,
 	.class = SONY_PIC_CLASS,
-	.ids = SONY_PIC_HID,
+	.ids = sony_pic_device_ids,
 	.owner = THIS_MODULE,
 	.ops = {
 		.add = sony_pic_add,
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index f15a58f..fa80f35 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -411,12 +411,13 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 
 	sprintf(ibm->acpi->driver->name, "%s_%s", IBM_NAME, ibm->name);
 	ibm->acpi->driver->ids = ibm->acpi->hid;
+
 	ibm->acpi->driver->ops.add = &tpacpi_device_add;
 
 	rc = acpi_bus_register_driver(ibm->acpi->driver);
 	if (rc < 0) {
 		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
-		       ibm->acpi->hid, rc);
+		       ibm->name, rc);
 		kfree(ibm->acpi->driver);
 		ibm->acpi->driver = NULL;
 	} else if (!rc)
@@ -1316,8 +1317,13 @@ errexit:
 	return res;
 }
 
+static const struct acpi_device_id ibm_htk_device_ids[] = {
+	{IBM_HKEY_HID, 0},
+	{"", 0},
+};
+
 static struct tp_acpi_drv_struct ibm_hotkey_acpidriver = {
-	.hid = IBM_HKEY_HID,
+	.hid = ibm_htk_device_ids,
 	.notify = hotkey_notify,
 	.handle = &hkey_handle,
 	.type = ACPI_DEVICE_NOTIFY,
@@ -2080,6 +2086,11 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
+static const struct acpi_device_id ibm_pci_device_ids[] = {
+	{PCI_ROOT_HID_STRING, 0},
+	{"", 0},
+};
+
 static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
 	{
 	 .notify = dock_notify,
@@ -2090,7 +2101,7 @@ static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
 	/* THIS ONE MUST NEVER BE USED FOR DRIVER AUTOLOADING.
 	 * We just use it to get notifications of dock hotplug
 	 * in very old thinkpads */
-	 .hid = PCI_ROOT_HID_STRING,
+	 .hid = ibm_pci_device_ids,
 	 .notify = dock_notify,
 	 .handle = &pci_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
@@ -2149,7 +2160,8 @@ static int __init dock_init2(struct ibm_init_struct *iibm)
 static void dock_notify(struct ibm_struct *ibm, u32 event)
 {
 	int docked = dock_docked();
-	int pci = ibm->acpi->hid && strstr(ibm->acpi->hid, PCI_ROOT_HID_STRING);
+	int pci = ibm->acpi->hid && ibm->acpi->device &&
+		acpi_match_device_ids(ibm->acpi->device, ibm_pci_device_ids);
 
 	if (event == 1 && !pci)	/* 570 */
 		acpi_bus_generate_event(ibm->acpi->device, event, 1);	/* button */
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index b7a4a88..88af089 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -193,7 +193,7 @@ static void thinkpad_acpi_module_exit(void);
 struct ibm_struct;
 
 struct tp_acpi_drv_struct {
-	char *hid;
+	const struct acpi_device_id *hid;
 	struct acpi_driver *driver;
 
 	void (*notify) (struct ibm_struct *, u32);
-- 
1.5.3.rc2.22.g69a9b
