From: akpm@osdl.org
Subject: [patch 5/8] Add support for the generic backlight device to the IBM ACPI driver
Date: Fri, 20 Oct 2006 14:30:28 -0700
Message-ID: <200610202130.k9KLUSTR003248@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:22400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992738AbWJTVbC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 17:31:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, hmacht@suse.de, apw@shadowen.org

From: Holger Macht <hmacht@suse.de>

Add support for the generic backlight interface below /sys/class/backlight.
The patch keeps the procfs brightness handling for backward compatibility.

For this to archive, the patch adds two generic functions brightness_get
and brightness_set to be used both by the procfs related and the sysfs
related methods.

[apw@shadowen.org: backlight users need to select BACKLIGHT_CLASS_DEVICE]
Signed-off-by: Holger Macht <hmacht@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/Kconfig    |    1 
 drivers/acpi/ibm_acpi.c |   75 ++++++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 14 deletions(-)

diff -puN drivers/acpi/Kconfig~add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver
+++ a/drivers/acpi/Kconfig
@@ -207,6 +207,7 @@ config ACPI_ASUS
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
+	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
diff -puN drivers/acpi/ibm_acpi.c~add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver drivers/acpi/ibm_acpi.c
--- a/drivers/acpi/ibm_acpi.c~add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver
+++ a/drivers/acpi/ibm_acpi.c
@@ -78,6 +78,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
@@ -243,6 +244,8 @@ struct ibm_struct {
 
 static struct proc_dir_entry *proc_dir = NULL;
 
+static struct backlight_device *ibm_backlight_device;
+
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
 #define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
@@ -1381,12 +1384,22 @@ static int ecdump_write(char *buf)
 
 static int brightness_offset = 0x31;
 
+static int brightness_get(struct backlight_device *bd)
+{
+       u8 level;
+       if (!acpi_ec_read(brightness_offset, &level))
+               return -EIO;
+
+       level &= 0x7;
+       return level;
+}
+
 static int brightness_read(char *p)
 {
 	int len = 0;
-	u8 level;
+	int level;
 
-	if (!acpi_ec_read(brightness_offset, &level)) {
+	if ((level = brightness_get(NULL)) < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
 		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
@@ -1401,16 +1414,34 @@ static int brightness_read(char *p)
 #define BRIGHTNESS_UP	4
 #define BRIGHTNESS_DOWN	5
 
-static int brightness_write(char *buf)
+static int brightness_set(int value)
 {
 	int cmos_cmd, inc, i;
-	u8 level;
+	int current_value = brightness_get(NULL);
+
+	value &= 7;
+
+	cmos_cmd = value > current_value ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
+	inc = value > current_value ? 1 : -1;
+	for (i = current_value; i != value; i += inc) {
+		if (!cmos_eval(cmos_cmd))
+			return -EIO;
+		if (!acpi_ec_write(brightness_offset, i + inc))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int brightness_write(char *buf)
+{
+	int level;
 	int new_level;
 	char *cmd;
 
 	while ((cmd = next_cmd(&buf))) {
-		if (!acpi_ec_read(brightness_offset, &level))
-			return -EIO;
+		if ((level = brightness_get(NULL)) < 0)
+			return level;
 		level &= 7;
 
 		if (strlencmp(cmd, "up") == 0) {
@@ -1423,19 +1454,17 @@ static int brightness_write(char *buf)
 		} else
 			return -EINVAL;
 
-		cmos_cmd = new_level > level ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
-		inc = new_level > level ? 1 : -1;
-		for (i = level; i != new_level; i += inc) {
-			if (!cmos_eval(cmos_cmd))
-				return -EIO;
-			if (!acpi_ec_write(brightness_offset, i + inc))
-				return -EIO;
-		}
+		brightness_set(new_level);
 	}
 
 	return 0;
 }
 
+static int brightness_update_status(struct backlight_device *bd)
+{
+	return brightness_set(bd->props->brightness);
+}
+
 static int volume_offset = 0x30;
 
 static int volume_read(char *p)
@@ -1963,10 +1992,20 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
+static struct backlight_properties ibm_backlight_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = brightness_get,
+        .update_status  = brightness_update_status,
+        .max_brightness = 7,
+};
+
 static void acpi_ibm_exit(void)
 {
 	int i;
 
+	if (ibm_backlight_device)
+		backlight_device_unregister(ibm_backlight_device);
+
 	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
 		ibm_exit(&ibms[i]);
 
@@ -2034,6 +2073,14 @@ static int __init acpi_ibm_init(void)
 		}
 	}
 
+	ibm_backlight_device = backlight_device_register("ibm", NULL,
+							 &ibm_backlight_data);
+        if (IS_ERR(ibm_backlight_device)) {
+		printk(IBM_ERR "Could not register ibm backlight device\n");
+		ibm_backlight_device = NULL;
+		acpi_ibm_exit();
+	}
+
 	return 0;
 }
 
_
