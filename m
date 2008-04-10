From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 07/13] ACPI: thinkpad-acpi: prepare light
	and LED for sysfs support
Date: Thu, 10 Apr 2008 00:52:59 -0300
Message-ID: <1207799585-10112-8-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1207799585-10112-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Do some preparatory work to add sysfs support to the thinklight and
thinkpad leds driver.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/Kconfig         |    2 +
 drivers/misc/thinkpad_acpi.c |  191 ++++++++++++++++++++++++++++++------------
 2 files changed, 138 insertions(+), 55 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 962817e..8a46cbc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -212,6 +212,8 @@ config THINKPAD_ACPI
 	select HWMON
 	select NVRAM
 	depends on INPUT
+	select NEW_LEDS
+	select LEDS_CLASS
 	---help---
 	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index f23acc8..c39f1ad 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -67,6 +67,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -85,6 +86,8 @@
 #define TP_CMOS_VOLUME_MUTE	2
 #define TP_CMOS_BRIGHTNESS_UP	4
 #define TP_CMOS_BRIGHTNESS_DOWN	5
+#define TP_CMOS_THINKLIGHT_ON	12
+#define TP_CMOS_THINKLIGHT_OFF	13
 
 /* NVRAM Addresses */
 enum tp_nvram_addr {
@@ -269,6 +272,13 @@ static enum {
 static int experimental;
 static u32 dbg_level;
 
+/* Special LED class that can defer work */
+struct tpacpi_led_classdev {
+	struct led_classdev led_classdev;
+	struct work_struct work;
+	enum led_brightness new_brightness;
+};
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -3236,6 +3246,39 @@ static struct ibm_struct video_driver_data = {
 TPACPI_HANDLE(lght, root, "\\LGHT");	/* A21e, A2xm/p, T20-22, X20-21 */
 TPACPI_HANDLE(ledb, ec, "LEDB");		/* G4x */
 
+static int light_get_status(void)
+{
+	int status = 0;
+
+	if (tp_features.light_status) {
+		if (!acpi_evalf(ec_handle, &status, "KBLT", "d"))
+			return -EIO;
+		return (!!status);
+	}
+
+	return -ENXIO;
+}
+
+static int light_set_status(int status)
+{
+	int rc;
+
+	if (tp_features.light) {
+		if (cmos_handle) {
+			rc = acpi_evalf(cmos_handle, NULL, NULL, "vd",
+					(status)?
+						TP_CMOS_THINKLIGHT_ON :
+						TP_CMOS_THINKLIGHT_OFF);
+		} else {
+			rc = acpi_evalf(lght_handle, NULL, NULL, "vd",
+					(status)? 1 : 0);
+		}
+		return (rc)? 0 : -EIO;
+	}
+
+	return -ENXIO;
+}
+
 static int __init light_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing light subdriver\n");
@@ -3262,7 +3305,7 @@ static int __init light_init(struct ibm_init_struct *iibm)
 static int light_read(char *p)
 {
 	int len = 0;
-	int status = 0;
+	int status;
 
 	if (!tp_features.light) {
 		len += sprintf(p + len, "status:\t\tnot supported\n");
@@ -3270,8 +3313,9 @@ static int light_read(char *p)
 		len += sprintf(p + len, "status:\t\tunknown\n");
 		len += sprintf(p + len, "commands:\ton, off\n");
 	} else {
-		if (!acpi_evalf(ec_handle, &status, "KBLT", "d"))
-			return -EIO;
+		status = light_get_status();
+		if (status < 0)
+			return status;
 		len += sprintf(p + len, "status:\t\t%s\n", onoff(status, 0));
 		len += sprintf(p + len, "commands:\ton, off\n");
 	}
@@ -3281,31 +3325,22 @@ static int light_read(char *p)
 
 static int light_write(char *buf)
 {
-	int cmos_cmd, lght_cmd;
 	char *cmd;
-	int success;
+	int newstatus = 0;
 
 	if (!tp_features.light)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "on") == 0) {
-			cmos_cmd = 0x0c;
-			lght_cmd = 1;
+			newstatus = 1;
 		} else if (strlencmp(cmd, "off") == 0) {
-			cmos_cmd = 0x0d;
-			lght_cmd = 0;
+			newstatus = 0;
 		} else
 			return -EINVAL;
-
-		success = cmos_handle ?
-		    acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd) :
-		    acpi_evalf(lght_handle, NULL, NULL, "vd", lght_cmd);
-		if (!success)
-			return -EIO;
 	}
 
-	return 0;
+	return light_set_status(newstatus);
 }
 
 static struct ibm_struct light_driver_data = {
@@ -3709,6 +3744,12 @@ enum {	/* For TPACPI_LED_OLD */
 	TPACPI_LED_EC_HLMS = 0x0e,	/* EC reg to select led to command */
 };
 
+enum led_status_t {
+	TPACPI_LED_OFF = 0,
+	TPACPI_LED_ON,
+	TPACPI_LED_BLINK,
+};
+
 static enum led_access_mode led_supported;
 
 TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
@@ -3717,6 +3758,69 @@ TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
 	   "LED",		/* all others */
 	   );			/* R30, R31 */
 
+static int led_get_status(unsigned int led)
+{
+	int status;
+
+	switch (led_supported) {
+	case TPACPI_LED_570:
+		if (!acpi_evalf(ec_handle,
+				&status, "GLED", "dd", 1 << led))
+			return -EIO;
+		return (status == 0)?
+				TPACPI_LED_OFF :
+				((status == 1)?
+					TPACPI_LED_ON :
+					TPACPI_LED_BLINK);
+	default:
+		return -ENXIO;
+	}
+
+	/* not reached */
+}
+
+static int led_set_status(unsigned int led, enum led_status_t ledstatus)
+{
+	/* off, on, blink. Index is led_status_t */
+	static const int const led_sled_arg1[] = { 0, 1, 3 };
+	static const int const led_exp_hlbl[] = { 0, 0, 1 };	/* led# * */
+	static const int const led_exp_hlcl[] = { 0, 1, 1 };	/* led# * */
+	static const int const led_led_arg1[] = { 0, 0x80, 0xc0 };
+
+	int rc = 0;
+
+	switch (led_supported) {
+	case TPACPI_LED_570:
+			/* 570 */
+			led = 1 << led;
+			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
+					led, led_sled_arg1[ledstatus]))
+				rc = -EIO;
+			break;
+	case TPACPI_LED_OLD:
+			/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
+			led = 1 << led;
+			rc = ec_write(TPACPI_LED_EC_HLMS, led);
+			if (rc >= 0)
+				rc = ec_write(TPACPI_LED_EC_HLBL,
+					      led * led_exp_hlbl[ledstatus]);
+			if (rc >= 0)
+				rc = ec_write(TPACPI_LED_EC_HLCL,
+					       led * led_exp_hlcl[ledstatus]);
+			break;
+	case TPACPI_LED_NEW:
+			/* all others */
+			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
+					led, led_led_arg1[ledstatus]))
+				rc = -EIO;
+			break;
+	default:
+		rc = -ENXIO;
+	}
+
+	return rc;
+}
+
 static int __init led_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing LED subdriver\n");
@@ -3742,7 +3846,9 @@ static int __init led_init(struct ibm_init_struct *iibm)
 	return (led_supported != TPACPI_LED_NONE)? 0 : 1;
 }
 
-#define led_status(s) ((s) == 0 ? "off" : ((s) == 1 ? "on" : "blinking"))
+#define str_led_status(s) \
+	((s) == TPACPI_LED_OFF ? "off" : \
+		((s) == TPACPI_LED_ON ? "on" : "blinking"))
 
 static int led_read(char *p)
 {
@@ -3758,11 +3864,11 @@ static int led_read(char *p)
 		/* 570 */
 		int i, status;
 		for (i = 0; i < 8; i++) {
-			if (!acpi_evalf(ec_handle,
-					&status, "GLED", "dd", 1 << i))
+			status = led_get_status(i);
+			if (status < 0)
 				return -EIO;
 			len += sprintf(p + len, "%d:\t\t%s\n",
-				       i, led_status(status));
+				       i, str_led_status(status));
 		}
 	}
 
@@ -3772,16 +3878,11 @@ static int led_read(char *p)
 	return len;
 }
 
-/* off, on, blink */
-static const int led_sled_arg1[] = { 0, 1, 3 };
-static const int led_exp_hlbl[] = { 0, 0, 1 };	/* led# * */
-static const int led_exp_hlcl[] = { 0, 1, 1 };	/* led# * */
-static const int led_led_arg1[] = { 0, 0x80, 0xc0 };
-
 static int led_write(char *buf)
 {
 	char *cmd;
-	int led, ind, ret;
+	int led, rc;
+	enum led_status_t s;
 
 	if (!led_supported)
 		return -ENODEV;
@@ -3791,38 +3892,18 @@ static int led_write(char *buf)
 			return -EINVAL;
 
 		if (strstr(cmd, "off")) {
-			ind = 0;
+			s = TPACPI_LED_OFF;
 		} else if (strstr(cmd, "on")) {
-			ind = 1;
+			s = TPACPI_LED_ON;
 		} else if (strstr(cmd, "blink")) {
-			ind = 2;
-		} else
-			return -EINVAL;
-
-		if (led_supported == TPACPI_LED_570) {
-			/* 570 */
-			led = 1 << led;
-			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
-					led, led_sled_arg1[ind]))
-				return -EIO;
-		} else if (led_supported == TPACPI_LED_OLD) {
-			/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
-			led = 1 << led;
-			ret = ec_write(TPACPI_LED_EC_HLMS, led);
-			if (ret >= 0)
-				ret = ec_write(TPACPI_LED_EC_HLBL,
-						led * led_exp_hlbl[ind]);
-			if (ret >= 0)
-				ret = ec_write(TPACPI_LED_EC_HLCL,
-						led * led_exp_hlcl[ind]);
-			if (ret < 0)
-				return ret;
+			s = TPACPI_LED_BLINK;
 		} else {
-			/* all others */
-			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
-					led, led_led_arg1[ind]))
-				return -EIO;
+			return -EINVAL;
 		}
+
+		rc = led_set_status(led, s);
+		if (rc < 0)
+			return rc;
 	}
 
 	return 0;
-- 
1.5.4.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
