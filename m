From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: ACPI: thinkpad-acpi: allow use of CMOS NVRAM for
	brightness control
Date: Sat, 14 Jul 2007 11:12:08 -0300
Message-ID: <11844223362399-git-send-email-hmh@hmh.eng.br>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11844223322928-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It appears that Lenovo decided to break the EC brightness control interface
in a weird way in their latest BIOSes.  Fortunately, the old CMOS NVRAM
interface works just fine in such BIOSes.

Add a module parameter that allows the user to select which strategy to use
for brightness control: EC, NVRAM, or both.  By default, do both (which is
the way thinkpad-acpi used to work until now) on IBM ThinkPads, and use
NVRAM only on Lenovo ThinkPads.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
index 7d92f26..e39cedb 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -141,6 +141,7 @@ config THINKPAD_ACPI
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
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
