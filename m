From: Len Brown <len.brown@intel.com>
Subject: [PATCH 58/77] ACPI: thinkpad-acpi: allow use of CMOS NVRAM for brightness control
Date: Sun, 22 Jul 2007 05:14:43 -0400
Message-ID: <11850957633613-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35331 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764086AbXGVJQE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:04 -0400
In-Reply-To: <11850957621605-git-send-email-len.brown@intel.com>
Message-Id: <24d3b77467b6aaf59e38dce4aa86d05541858195.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

It appears that Lenovo decided to break the EC brightness control interface
in a weird way in their latest BIOSes.  Fortunately, the old CMOS NVRAM
interface works just fine in such BIOSes.

Add a module parameter that allows the user to select which strategy to use
for brightness control: EC, NVRAM, or both.  By default, do both (which is
the way thinkpad-acpi used to work until now) on IBM ThinkPads, and use
NVRAM only on Lenovo ThinkPads.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |    6 ++++
 drivers/misc/Kconfig            |    1 +
 drivers/misc/thinkpad_acpi.c    |   62 +++++++++++++++++++++++++++++++++-----
 drivers/misc/thinkpad_acpi.h    |    7 ++++
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index c670363..c145bcc 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -860,6 +860,12 @@ cannot be controlled.
 The backlight control has eight levels, ranging from 0 to 7.  Some of the
 levels may not be distinct.
 
+There are two interfaces to the firmware for brightness control, EC and CMOS.
+To select which one should be used, use the brightness_mode module parameter:
+brightness_mode=1 selects EC mode, brightness_mode=2 selects CMOS mode,
+brightness_mode=3 selects both EC and CMOS.  The driver tries to autodetect
+which interface to use.
+
 Procfs notes:
 
 	The available commands are:
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5197f9b..aaaa61e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -150,6 +150,7 @@ config THINKPAD_ACPI
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
+	select NVRAM
 	---help---
 	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 99500af..5318eb2 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2953,9 +2953,22 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
 
+	if (!brightness_mode) {
+		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO)
+			brightness_mode = 2;
+		else
+			brightness_mode = 3;
+
+		dbg_printk(TPACPI_DBG_INIT, "selected brightness_mode=%d\n",
+			brightness_mode);
+	}
+
+	if (brightness_mode > 3)
+		return -EINVAL;
+
 	b = brightness_get(NULL);
 	if (b < 0)
-		return b;
+		return 1;
 
 	ibm_backlight_device = backlight_device_register(
 					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
@@ -2991,13 +3004,35 @@ static int brightness_update_status(struct backlight_device *bd)
 				bd->props.brightness : 0);
 }
 
+/*
+ * ThinkPads can read brightness from two places: EC 0x31, or
+ * CMOS NVRAM byte 0x5E, bits 0-3.
+ */
 static int brightness_get(struct backlight_device *bd)
 {
-	u8 level;
-	if (!acpi_ec_read(brightness_offset, &level))
-		return -EIO;
+	u8 lec = 0, lcmos = 0, level = 0;
 
-	level &= 0x7;
+	if (brightness_mode & 1) {
+		if (!acpi_ec_read(brightness_offset, &lec))
+			return -EIO;
+		lec &= 7;
+		level = lec;
+	};
+	if (brightness_mode & 2) {
+		lcmos = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
+			 & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
+			>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
+		level = lcmos;
+	}
+
+	if (brightness_mode == 3 && lec != lcmos) {
+		printk(IBM_ERR
+			"CMOS NVRAM (%u) and EC (%u) do not agree "
+			"on display brightness level\n",
+			(unsigned int) lcmos,
+			(unsigned int) lec);
+		return -EIO;
+	}
 
 	return level;
 }
@@ -3007,14 +3042,20 @@ static int brightness_set(int value)
 	int cmos_cmd, inc, i;
 	int current_value = brightness_get(NULL);
 
-	value &= 7;
+	if (value > 7)
+		return -EINVAL;
 
-	cmos_cmd = value > current_value ? TP_CMOS_BRIGHTNESS_UP : TP_CMOS_BRIGHTNESS_DOWN;
+	cmos_cmd = value > current_value ?
+			TP_CMOS_BRIGHTNESS_UP :
+			TP_CMOS_BRIGHTNESS_DOWN;
 	inc = value > current_value ? 1 : -1;
+
 	for (i = current_value; i != value; i += inc) {
-		if (issue_thinkpad_cmos_command(cmos_cmd))
+		if ((brightness_mode & 2) &&
+		    issue_thinkpad_cmos_command(cmos_cmd))
 			return -EIO;
-		if (!acpi_ec_write(brightness_offset, i + inc))
+		if ((brightness_mode & 1) &&
+		    !acpi_ec_write(brightness_offset, i + inc))
 			return -EIO;
 	}
 
@@ -4485,6 +4526,9 @@ module_param(force_load, bool, 0);
 static int fan_control_allowed;
 module_param_named(fan_control, fan_control_allowed, bool, 0);
 
+static int brightness_mode;
+module_param_named(brightness_mode, brightness_mode, int, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 09b2282..b7a4a88 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -32,6 +32,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 
+#include <linux/nvram.h>
 #include <linux/proc_fs.h>
 #include <linux/sysfs.h>
 #include <linux/backlight.h>
@@ -80,6 +81,11 @@
 #define TP_CMOS_BRIGHTNESS_UP	4
 #define TP_CMOS_BRIGHTNESS_DOWN	5
 
+/* ThinkPad CMOS NVRAM constants */
+#define TP_NVRAM_ADDR_BRIGHTNESS       0x5e
+#define TP_NVRAM_MASK_LEVEL_BRIGHTNESS 0x07
+#define TP_NVRAM_POS_LEVEL_BRIGHTNESS 0
+
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
 #define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
@@ -323,6 +329,7 @@ static int bluetooth_write(char *buf);
 
 static struct backlight_device *ibm_backlight_device;
 static int brightness_offset = 0x31;
+static int brightness_mode;
 
 static int brightness_init(struct ibm_init_struct *iibm);
 static void brightness_exit(void);
-- 
1.5.3.rc2.22.g69a9b
