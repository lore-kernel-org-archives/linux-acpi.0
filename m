From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Make ibm_acpi use generic backlight infrastructure
Date: Wed, 8 Feb 2006 16:10:56 +0000
Message-ID: <20060208161056.GA28922@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:27790 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161076AbWBHQLD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Feb 2006 11:11:03 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org

The included patch allows brightness to be controlled through 
/sys/class/backlight on IBM ACPI machines.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 5cc0903..a18cad4 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -78,6 +78,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
@@ -243,6 +245,8 @@ struct ibm_struct {
 
 static struct proc_dir_entry *proc_dir = NULL;
 
+static struct backlight_device *ibm_backlight_device;
+
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
 #define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
@@ -1317,15 +1321,25 @@ static int ecdump_write(char *buf)
 
 static int brightness_offset = 0x31;
 
+static int brightness_read_value(struct backlight_device *bd)
+{
+	u8 level;
+	if (!acpi_ec_read(brightness_offset, &level))
+		return -EIO;
+
+	level &= 0x7;
+	return level;
+}
+
 static int brightness_read(char *p)
 {
 	int len = 0;
-	u8 level;
+	int level = brightness_read_value(NULL);
 
-	if (!acpi_ec_read(brightness_offset, &level)) {
+	if (level < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
-		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
+		len += sprintf(p + len, "level:\t\t%d\n", level);
 		len += sprintf(p + len, "commands:\tup, down\n");
 		len += sprintf(p + len, "commands:\tlevel <level>"
 			       " (<level> is 0-7)\n");
@@ -1337,9 +1351,32 @@ static int brightness_read(char *p)
 #define BRIGHTNESS_UP	4
 #define BRIGHTNESS_DOWN	5
 
+static int brightness_write_value(struct backlight_device *bd, int value)
+{
+	int current_value = brightness_read_value(bd);
+	int inc;
+	int cmos_cmd; 
+
+	value &= 7;
+
+	cmos_cmd = value > current_value ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
+
+	inc = value > current_value ? 1 : -1;
+
+	while (value != current_value) {
+		current_value += inc;
+
+		if (!cmos_eval(cmos_cmd))
+			return -EIO;
+		if (!acpi_ec_write(brightness_offset, current_value))
+			return -EIO;
+	}
+
+	return 0;
+}
+
 static int brightness_write(char *buf)
 {
-	int cmos_cmd, inc, i;
 	u8 level;
 	int new_level;
 	char *cmd;
@@ -1359,14 +1396,8 @@ static int brightness_write(char *buf)
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
+		brightness_write_value(NULL, new_level);
+		
 	}
 
 	return 0;
@@ -1890,10 +1921,20 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
+
+static struct backlight_properties ibmbl_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = brightness_read_value,
+        .set_brightness = brightness_write_value,
+        .max_brightness = 7,
+};
+
 static void acpi_ibm_exit(void)
 {
 	int i;
 
+	backlight_device_unregister(ibm_backlight_device);
+
 	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
 		ibm_exit(&ibms[i]);
 
@@ -1959,6 +2000,11 @@ static int __init acpi_ibm_init(void)
 		}
 	}
 
+	ibm_backlight_device = backlight_device_register ("ibm_bl", NULL,
+							  &ibmbl_data);
+        if (IS_ERR (ibm_backlight_device))
+		acpi_ibm_exit();
+
 	return 0;
 }

-- 
Matthew Garrett | mjg59@srcf.ucam.org
