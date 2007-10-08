From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 2/3] ACPI: thinkpad-acpi: support 16 levels
	of brightness (v2)
Date: Mon,  8 Oct 2007 10:04:01 -0300
Message-ID: <1191848642-22530-3-git-send-email-hmh@hmh.eng.br>
References: <1191848642-22530-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1191848642-22530-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Lenovo ThinkPads with ACPI Video brightness control often have 16
brightness levels in EC, and not just eight levels like older ThinkPads.

We detect the number of brightness levels by the presence of a _BCL method
with 18 entries (16 levels plus the on-battery and on-ac recommended
levels).  If _BCL is not there, we assume eight levels (T60, for example).
Otherwise we assume sixteen levels (T61, X61, etc).

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   61 +++++++++++++++-----------
 drivers/misc/thinkpad_acpi.c    |   93 ++++++++++++++++++++++++++++++++++----
 drivers/misc/thinkpad_acpi.h    |    3 +-
 3 files changed, 120 insertions(+), 37 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 3b95bba..4db98b3 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -923,19 +923,26 @@ sysfs backlight device "thinkpad_screen"
 This feature allows software control of the LCD brightness on ThinkPad
 models which don't have a hardware brightness slider.
 
-It has some limitations: the LCD backlight cannot be actually turned on or off
-by this interface, and in many ThinkPad models, the "dim while on battery"
-functionality will be enabled by the BIOS when this interface is used, and
-cannot be controlled.
-
-The backlight control has eight levels, ranging from 0 to 7.  Some of the
-levels may not be distinct.
-
-There are two interfaces to the firmware for brightness control, EC and CMOS.
-To select which one should be used, use the brightness_mode module parameter:
-brightness_mode=1 selects EC mode, brightness_mode=2 selects CMOS mode,
-brightness_mode=3 selects both EC and CMOS.  The driver tries to autodetect
-which interface to use.
+It has some limitations: the LCD backlight cannot be actually turned on or
+off by this interface, and in many ThinkPad models, the "dim while on
+battery" functionality will be enabled by the BIOS when this interface is
+used, and cannot be controlled.
+
+On IBM (and some of the earlier Lenovo) ThinkPads, the backlight control
+has eight brightness levels, ranging from 0 to 7.  Some of the levels
+may not be distinct.  Later Lenovo models that implement the ACPI
+display backlight brightness control methods have 16 levels, ranging
+from 0 to 15.
+
+There are two interfaces to the firmware for direct brightness control,
+EC and CMOS.  To select which one should be used, use the
+brightness_mode module parameter: brightness_mode=1 selects EC mode,
+brightness_mode=2 selects CMOS mode, brightness_mode=3 selects both EC
+and CMOS.  The driver tries to autodetect which interface to use.
+
+When display backlight brightness controls are available through the
+standard ACPI interface, it is best to use it instead of this direct
+ThinkPad-specific interface.
 
 Procfs notes:
 
@@ -947,11 +954,11 @@ Procfs notes:
 
 Sysfs notes:
 
-The interface is implemented through the backlight sysfs class, which is poorly
-documented at this time.
+The interface is implemented through the backlight sysfs class, which is
+poorly documented at this time.
 
-Locate the thinkpad_screen device under /sys/class/backlight, and inside it
-there will be the following attributes:
+Locate the thinkpad_screen device under /sys/class/backlight, and inside
+it there will be the following attributes:
 
 	max_brightness:
 		Reads the maximum brightness the hardware can be set to.
@@ -961,17 +968,19 @@ there will be the following attributes:
 		Reads what brightness the screen is set to at this instant.
 
 	brightness:
-		Writes request the driver to change brightness to the given
-		value.  Reads will tell you what brightness the driver is trying
-		to set the display to when "power" is set to zero and the display
-		has not been dimmed by a kernel power management event.
+		Writes request the driver to change brightness to the
+		given value.  Reads will tell you what brightness the
+		driver is trying to set the display to when "power" is set
+		to zero and the display has not been dimmed by a kernel
+		power management event.
 
 	power:
-		power management mode, where 0 is "display on", and 1 to 3 will
-		dim the display backlight to brightness level 0 because
-		thinkpad-acpi cannot really turn the backlight off.  Kernel
-		power management events can temporarily increase the current
-		power management level, i.e. they can dim the display.
+		power management mode, where 0 is "display on", and 1 to 3
+		will dim the display backlight to brightness level 0
+		because thinkpad-acpi cannot really turn the backlight
+		off.  Kernel power management events can temporarily
+		increase the current power management level, i.e. they can
+		dim the display.
 
 
 Volume control -- /proc/acpi/ibm/volume
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 37891a8..2a573db 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3114,6 +3114,68 @@ static struct backlight_ops ibm_backlight_data = {
 
 static struct mutex brightness_mutex;
 
+static int __init tpacpi_query_bcl_levels(acpi_handle handle)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	int rc;
+
+	if (ACPI_SUCCESS(acpi_evaluate_object(handle, NULL, NULL, &buffer))) {
+		obj = (union acpi_object *)buffer.pointer;
+		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
+			printk(IBM_ERR "Invalid _BCL data\n");
+			rc = 0;
+		} else {
+			if (obj->package.count >= 2)
+				rc = obj->package.count - 2;
+			else
+				rc = 0;
+		}
+	} else {
+		return 0;
+	}
+
+	kfree(buffer.pointer);
+	return rc;
+}
+
+static acpi_status __init brightness_find_bcl(acpi_handle handle, u32 lvl,
+					void *context, void **rv)
+{
+	char name[ACPI_PATH_SEGMENT_LENGTH];
+	struct acpi_buffer buffer = { sizeof(name), &name };
+
+	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
+	    !strncmp("_BCL", name, sizeof(name) - 1)) {
+		if (tpacpi_query_bcl_levels(handle) == 16) {
+			*rv = handle;
+			return AE_CTRL_TERMINATE;
+		} else {
+			return AE_OK;
+		}
+	} else {
+		return AE_OK;
+	}
+}
+
+static int __init brightness_check_levels(void)
+{
+	int status;
+	void *found_node = NULL;
+
+	if (!vid_handle) {
+		IBM_ACPIHANDLE_INIT(vid);
+	}
+	if (!vid_handle)
+		return 0;
+
+	/* Search for a _BCL method with 16 levels */
+	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
+					brightness_find_bcl, NULL, &found_node);
+
+	return (ACPI_SUCCESS(status) && found_node != NULL);
+}
+
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
@@ -3135,10 +3197,17 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	if (brightness_mode > 3)
 		return -EINVAL;
 
+	tp_features.bright_16levels =
+			thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO &&
+			brightness_check_levels();
+
 	b = brightness_get(NULL);
 	if (b < 0)
 		return 1;
 
+	if (tp_features.bright_16levels)
+		printk(IBM_INFO "detected a 16-level brightness capable ThinkPad\n");
+
 	ibm_backlight_device = backlight_device_register(
 					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
 					&ibm_backlight_data);
@@ -3148,7 +3217,8 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	}
 	vdbg_printk(TPACPI_DBG_INIT, "brightness is supported\n");
 
-	ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.max_brightness =
+				(tp_features.bright_16levels)? 15 : 7;
 	ibm_backlight_device->props.brightness = b;
 	backlight_update_status(ibm_backlight_device);
 
@@ -3184,13 +3254,14 @@ static int brightness_get(struct backlight_device *bd)
 	if (brightness_mode & 1) {
 		if (!acpi_ec_read(brightness_offset, &lec))
 			return -EIO;
-		lec &= 7;
+		lec &= (tp_features.bright_16levels)? 0x0f : 0x07;
 		level = lec;
 	};
 	if (brightness_mode & 2) {
 		lcmos = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
 			 & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
 			>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
+		lcmos &= (tp_features.bright_16levels)? 0x0f : 0x07;
 		level = lcmos;
 	}
 
@@ -3211,7 +3282,7 @@ static int brightness_set(int value)
 	int cmos_cmd, inc, i, res;
 	int current_value;
 
-	if (value > 7)
+	if (value > ((tp_features.bright_16levels)? 15 : 7))
 		return -EINVAL;
 
 	res = mutex_lock_interruptible(&brightness_mutex);
@@ -3227,7 +3298,7 @@ static int brightness_set(int value)
 	cmos_cmd = value > current_value ?
 			TP_CMOS_BRIGHTNESS_UP :
 			TP_CMOS_BRIGHTNESS_DOWN;
-	inc = value > current_value ? 1 : -1;
+	inc = (value > current_value)? 1 : -1;
 
 	res = 0;
 	for (i = current_value; i != value; i += inc) {
@@ -3256,10 +3327,11 @@ static int brightness_read(char *p)
 	if ((level = brightness_get(NULL)) < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
-		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
+		len += sprintf(p + len, "level:\t\t%d\n", level);
 		len += sprintf(p + len, "commands:\tup, down\n");
 		len += sprintf(p + len, "commands:\tlevel <level>"
-			       " (<level> is 0-7)\n");
+			       " (<level> is 0-%d)\n",
+			       (tp_features.bright_16levels) ? 15 : 7);
 	}
 
 	return len;
@@ -3270,18 +3342,19 @@ static int brightness_write(char *buf)
 	int level;
 	int new_level;
 	char *cmd;
+	int max_level = (tp_features.bright_16levels) ? 15 : 7;
 
 	while ((cmd = next_cmd(&buf))) {
 		if ((level = brightness_get(NULL)) < 0)
 			return level;
-		level &= 7;
 
 		if (strlencmp(cmd, "up") == 0) {
-			new_level = level == 7 ? 7 : level + 1;
+			new_level = level == (max_level)?
+						max_level : level + 1;
 		} else if (strlencmp(cmd, "down") == 0) {
-			new_level = level == 0 ? 0 : level - 1;
+			new_level = level == 0? 0 : level - 1;
 		} else if (sscanf(cmd, "level %d", &new_level) == 1 &&
-			   new_level >= 0 && new_level <= 7) {
+			   new_level >= 0 && new_level <= max_level) {
 			/* new_level set */
 		} else
 			return -EINVAL;
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index c5fdd68..de0f343 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -84,7 +84,7 @@
 
 /* ThinkPad CMOS NVRAM constants */
 #define TP_NVRAM_ADDR_BRIGHTNESS       0x5e
-#define TP_NVRAM_MASK_LEVEL_BRIGHTNESS 0x07
+#define TP_NVRAM_MASK_LEVEL_BRIGHTNESS 0x0f
 #define TP_NVRAM_POS_LEVEL_BRIGHTNESS 0
 
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
@@ -246,6 +246,7 @@ static struct {
 	u32 hotkey_wlsw:1;
 	u32 light:1;
 	u32 light_status:1;
+	u32 bright_16levels:1;
 	u32 wan:1;
 	u32 fan_ctrl_status_undef:1;
 	u32 input_device_registered:1;
-- 
1.5.3.2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
