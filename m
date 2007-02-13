From: Len Brown <lenb@kernel.org>
Subject: [PATCH 38/41] ACPI: fix acpi_driver.name usage
Date: Tue, 13 Feb 2007 00:49:40 -0500
Message-ID: <11713458271642-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org> <11713458233765-git-send-email-lenb@kernel.org> <11713458242872-git-send-email-lenb@kernel.org> <11713458251648-git-send-email-lenb@kernel.org> <11713458262743-git-send-email-lenb@kernel.org> <11713458271675-
 git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39554 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbXBMFua (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:30 -0500
In-Reply-To: <11713458271675-git-send-email-lenb@kernel.org>
Message-Id: <c2b6705b75d9c7aff98a4602a32230639e10891c.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

It was erroneously used as a description rather than a name.

ie. turn this:

lenb@se7525gp2:/sys> ls bus/acpi/drivers
ACPI AC Adapter Driver  ACPI Embedded Controller Driver  ACPI Power Resource Driver
ACPI Battery Driver     ACPI Fan Driver                  ACPI Processor Driver
ACPI Button Driver      ACPI PCI Interrupt Link Driver   ACPI Thermal Zone Driver
ACPI container driver   ACPI PCI Root Bridge Driver      hpet

into this:

lenb@se7525gp2:~> ls /sys/bus/acpi/drivers
ac  battery  button  container  ec  fan  hpet  pci_link  pci_root  power  processor  thermal

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c              |    2 +-
 drivers/acpi/acpi_memhotplug.c |    2 +-
 drivers/acpi/asus_acpi.c       |    2 +-
 drivers/acpi/battery.c         |    2 +-
 drivers/acpi/bay.c             |    2 +-
 drivers/acpi/button.c          |    2 +-
 drivers/acpi/container.c       |    2 +-
 drivers/acpi/ec.c              |    2 +-
 drivers/acpi/fan.c             |    2 +-
 drivers/acpi/i2c_ec.c          |    2 +-
 drivers/acpi/pci_link.c        |    2 +-
 drivers/acpi/pci_root.c        |    2 +-
 drivers/acpi/power.c           |    2 +-
 drivers/acpi/processor_core.c  |    2 +-
 drivers/acpi/sbs.c             |    2 +-
 drivers/acpi/thermal.c         |    2 +-
 drivers/acpi/video.c           |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index a9b30e6..17eef27 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -58,7 +58,7 @@ static int acpi_ac_remove(struct acpi_device *device, int type);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_ac_driver = {
-	.name = ACPI_AC_DRIVER_NAME,
+	.name = "ac",
 	.class = ACPI_AC_CLASS,
 	.ids = ACPI_AC_HID,
 	.ops = {
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 88a6dc3..d677130 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -60,7 +60,7 @@ static int acpi_memory_device_remove(struct acpi_device *device, int type);
 static int acpi_memory_device_start(struct acpi_device *device);
 
 static struct acpi_driver acpi_memory_device_driver = {
-	.name = ACPI_MEMORY_DEVICE_DRIVER_NAME,
+	.name = "acpi_memhotplug",
 	.class = ACPI_MEMORY_DEVICE_CLASS,
 	.ids = ACPI_MEMORY_DEVICE_HID,
 	.ops = {
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 31ad70a..40a2f4c 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -421,7 +421,7 @@ static struct asus_hotk *hotk;
 static int asus_hotk_add(struct acpi_device *device);
 static int asus_hotk_remove(struct acpi_device *device, int type);
 static struct acpi_driver asus_hotk_driver = {
-	.name = ACPI_HOTK_NAME,
+	.name = "asus_acpi",
 	.class = ACPI_HOTK_CLASS,
 	.ids = ACPI_HOTK_HID,
 	.ops = {
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4b8db56..da29d9d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -67,7 +67,7 @@ static int acpi_battery_remove(struct acpi_device *device, int type);
 static int acpi_battery_resume(struct acpi_device *device);
 
 static struct acpi_driver acpi_battery_driver = {
-	.name = ACPI_BATTERY_DRIVER_NAME,
+	.name = "battery",
 	.class = ACPI_BATTERY_CLASS,
 	.ids = ACPI_BATTERY_HID,
 	.ops = {
diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 19fe57d..1f88858 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -51,7 +51,7 @@ static int acpi_bay_add(struct acpi_device *device);
 static int acpi_bay_remove(struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_bay_driver = {
-	.name = ACPI_BAY_DRIVER_NAME,
+	.name = "bay",
 	.class = ACPI_BAY_CLASS,
 	.ids = ACPI_BAY_HID,
 	.ops = {
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 28ce5c6..45f960d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -73,7 +73,7 @@ static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
 static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_button_driver = {
-	.name = ACPI_BUTTON_DRIVER_NAME,
+	.name = "button",
 	.class = ACPI_BUTTON_CLASS,
 	.ids = "button_power,button_sleep,PNP0C0D,PNP0C0C,PNP0C0E",
 	.ops = {
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index f3e59af..0e36062 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -56,7 +56,7 @@ static int acpi_container_add(struct acpi_device *device);
 static int acpi_container_remove(struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_container_driver = {
-	.name = ACPI_CONTAINER_DRIVER_NAME,
+	.name = "container",
 	.class = ACPI_CONTAINER_CLASS,
 	.ids = "ACPI0004,PNP0A05,PNP0A06",
 	.ops = {
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a5c0b5c..9d67952 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -80,7 +80,7 @@ static int acpi_ec_stop(struct acpi_device *device, int type);
 static int acpi_ec_add(struct acpi_device *device);
 
 static struct acpi_driver acpi_ec_driver = {
-	.name = ACPI_EC_DRIVER_NAME,
+	.name = "ec",
 	.class = ACPI_EC_CLASS,
 	.ids = ACPI_EC_HID,
 	.ops = {
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index b902d3b..5ac727e 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -52,7 +52,7 @@ static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state);
 static int acpi_fan_resume(struct acpi_device *device);
 
 static struct acpi_driver acpi_fan_driver = {
-	.name = ACPI_FAN_DRIVER_NAME,
+	.name = "fan",
 	.class = ACPI_FAN_CLASS,
 	.ids = "PNP0C0B",
 	.ops = {
diff --git a/drivers/acpi/i2c_ec.c b/drivers/acpi/i2c_ec.c
index 62af6da..d2fde7a 100644
--- a/drivers/acpi/i2c_ec.c
+++ b/drivers/acpi/i2c_ec.c
@@ -39,7 +39,7 @@ static int acpi_ec_hc_add(struct acpi_device *device);
 static int acpi_ec_hc_remove(struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_ec_hc_driver = {
-	.name = ACPI_EC_HC_DRIVER_NAME,
+	.name = "i2c_ec",
 	.class = ACPI_EC_HC_CLASS,
 	.ids = ACPI_EC_HC_HID,
 	.ops = {
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index da22c5e..a95f03f 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -56,7 +56,7 @@ static int acpi_pci_link_add(struct acpi_device *device);
 static int acpi_pci_link_remove(struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_pci_link_driver = {
-	.name = ACPI_PCI_LINK_DRIVER_NAME,
+	.name = "pci_link",
 	.class = ACPI_PCI_LINK_CLASS,
 	.ids = ACPI_PCI_LINK_HID,
 	.ops = {
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 3db2cd3..7bf24c3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -46,7 +46,7 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type);
 static int acpi_pci_root_start(struct acpi_device *device);
 
 static struct acpi_driver acpi_pci_root_driver = {
-	.name = ACPI_PCI_ROOT_DRIVER_NAME,
+	.name = "pci_root",
 	.class = ACPI_PCI_ROOT_CLASS,
 	.ids = ACPI_PCI_ROOT_HID,
 	.ops = {
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 26e8edc..09b855d 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -60,7 +60,7 @@ static int acpi_power_remove(struct acpi_device *device, int type);
 static int acpi_power_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_power_driver = {
-	.name = ACPI_POWER_DRIVER_NAME,
+	.name = "power",
 	.class = ACPI_POWER_CLASS,
 	.ids = ACPI_POWER_HID,
 	.ops = {
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 13135f8..19c44b5 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -89,7 +89,7 @@ static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
 
 static struct acpi_driver acpi_processor_driver = {
-	.name = ACPI_PROCESSOR_DRIVER_NAME,
+	.name = "processor",
 	.class = ACPI_PROCESSOR_CLASS,
 	.ids = ACPI_PROCESSOR_HID,
 	.ops = {
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f5b714d..1c2d8fb 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -110,7 +110,7 @@ static void acpi_battery_smbus_err_handler(struct acpi_ec_smbus *smbus);
 static void acpi_sbs_update_queue(void *data);
 
 static struct acpi_driver acpi_sbs_driver = {
-	.name = ACPI_SBS_DRIVER_NAME,
+	.name = "sbs",
 	.class = ACPI_SBS_CLASS,
 	.ids = ACPI_SBS_HID,
 	.ops = {
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index bf0a9f2..c34a89d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -98,7 +98,7 @@ static ssize_t acpi_thermal_write_polling(struct file *, const char __user *,
 					  size_t, loff_t *);
 
 static struct acpi_driver acpi_thermal_driver = {
-	.name = ACPI_THERMAL_DRIVER_NAME,
+	.name = "thermal",
 	.class = ACPI_THERMAL_CLASS,
 	.ids = ACPI_THERMAL_HID,
 	.ops = {
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index a095d01..0c44ffd 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -75,7 +75,7 @@ static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_video_bus = {
-	.name = ACPI_VIDEO_DRIVER_NAME,
+	.name = "video",
 	.class = ACPI_VIDEO_CLASS,
 	.ids = ACPI_VIDEO_HID,
 	.ops = {
-- 
1.5.0.rc4.345.gb4d2
