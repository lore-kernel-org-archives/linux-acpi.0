From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 12/12] thinkpad-acpi: rework brightness
	support
Date: Sat,  4 Apr 2009 01:25:53 -0300
Message-ID: <1238819153-16004-13-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1238819153-16004-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Refactor and redesign the brightness control backend...

In order to fix bugzilla #11750...

Add a new brightness control mode: support direct NVRAM checkpointing
of the backlight level (i.e. store directly to NVRAM without the need
for UCMS calls), and use that together with the EC-based control.
Disallow UCMS+EC, thus avoiding races with the SMM firmware.

Switch the models that define HBRV (EC Brightness Value) in the DSDT
to the new mode.  These are: T40-T43, R50-R52, R50e, R51e, X31-X41.

Change the default for all other IBM ThinkPads to UCMS-only.  The
Lenovo models already default to UCMS-only.

Reported-by: Alexey Fisher <bug-track-M18mAb7Tlt0yCq4wW13eYl6hYfS7NtTn@public.gmane.org>
Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/laptops/thinkpad-acpi.txt |   12 +-
 drivers/platform/x86/thinkpad_acpi.c    |  317 +++++++++++++++++++++----------
 2 files changed, 227 insertions(+), 102 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 25ed43d..3d76507 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1157,10 +1157,15 @@ display backlight brightness control methods have 16 levels, ranging
 from 0 to 15.
 
 There are two interfaces to the firmware for direct brightness control,
-EC and CMOS.  To select which one should be used, use the
+EC and UCMS (or CMOS).  To select which one should be used, use the
 brightness_mode module parameter: brightness_mode=1 selects EC mode,
-brightness_mode=2 selects CMOS mode, brightness_mode=3 selects both EC
-and CMOS.  The driver tries to auto-detect which interface to use.
+brightness_mode=2 selects UCMS mode, brightness_mode=3 selects EC
+mode with NVRAM backing (so that brightness changes are remembered
+across shutdown/reboot).
+
+The driver tries to select which interface to use from a table of
+defaults for each ThinkPad model.  If it makes a wrong choice, please
+report this as a bug, so that we can fix it.
 
 When display backlight brightness controls are available through the
 standard ACPI interface, it is best to use it instead of this direct
@@ -1498,6 +1503,7 @@ to enable more than one output class, just add their values.
 				(bluetooth, WWAN, UWB...)
 	0x0008			HKEY event interface, hotkeys
 	0x0010			Fan control
+	0x0020			Backlight brightness
 
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 27c9480..a40b075 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -192,6 +192,7 @@ enum {
 #define TPACPI_DBG_RFKILL	0x0004
 #define TPACPI_DBG_HKEY		0x0008
 #define TPACPI_DBG_FAN		0x0010
+#define TPACPI_DBG_BRGHT	0x0020
 
 #define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -274,7 +275,6 @@ static struct {
 
 static struct {
 	u16 hotkey_mask_ff:1;
-	u16 bright_cmos_ec_unsync:1;
 } tp_warned;
 
 struct thinkpad_id_data {
@@ -5526,6 +5526,20 @@ static struct ibm_struct ecdump_driver_data = {
 
 #define TPACPI_BACKLIGHT_DEV_NAME "thinkpad_screen"
 
+/*
+ * ThinkPads can read brightness from two places: EC HBRV (0x31), or
+ * CMOS NVRAM byte 0x5E, bits 0-3.
+ *
+ * EC HBRV (0x31) has the following layout
+ *   Bit 7: unknown function
+ *   Bit 6: unknown function
+ *   Bit 5: Z: honour scale changes, NZ: ignore scale changes
+ *   Bit 4: must be set to zero to avoid problems
+ *   Bit 3-0: backlight brightness level
+ *
+ * brightness_get_raw returns status data in the HBRV layout
+ */
+
 enum {
 	TP_EC_BACKLIGHT = 0x31,
 
@@ -5535,108 +5549,164 @@ enum {
 	TP_EC_BACKLIGHT_MAPSW = 0x20,
 };
 
+enum tpacpi_brightness_access_mode {
+	TPACPI_BRGHT_MODE_AUTO = 0,	/* Not implemented yet */
+	TPACPI_BRGHT_MODE_EC,		/* EC control */
+	TPACPI_BRGHT_MODE_UCMS_STEP,	/* UCMS step-based control */
+	TPACPI_BRGHT_MODE_ECNVRAM,	/* EC control w/ NVRAM store */
+	TPACPI_BRGHT_MODE_MAX
+};
+
 static struct backlight_device *ibm_backlight_device;
-static int brightness_mode;
+
+static enum tpacpi_brightness_access_mode brightness_mode =
+		TPACPI_BRGHT_MODE_MAX;
+
 static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
 
 static struct mutex brightness_mutex;
 
-/*
- * ThinkPads can read brightness from two places: EC 0x31, or
- * CMOS NVRAM byte 0x5E, bits 0-3.
- *
- * EC 0x31 has the following layout
- *   Bit 7: unknown function
- *   Bit 6: unknown function
- *   Bit 5: Z: honour scale changes, NZ: ignore scale changes
- *   Bit 4: must be set to zero to avoid problems
- *   Bit 3-0: backlight brightness level
- *
- * brightness_get_raw returns status data in the EC 0x31 layout
- */
-static int brightness_get_raw(int *status)
+/* NVRAM brightness access,
+ * call with brightness_mutex held! */
+static unsigned int tpacpi_brightness_nvram_get(void)
 {
-	u8 lec = 0, lcmos = 0, level = 0;
+	u8 lnvram;
 
-	if (brightness_mode & 1) {
-		if (!acpi_ec_read(TP_EC_BACKLIGHT, &lec))
-			return -EIO;
-		level = lec & TP_EC_BACKLIGHT_LVLMSK;
-	};
-	if (brightness_mode & 2) {
-		lcmos = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
-			 & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
-			>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
-		lcmos &= (tp_features.bright_16levels)? 0x0f : 0x07;
-		level = lcmos;
-	}
-
-	if (brightness_mode == 3) {
-		*status = lec;	/* Prefer EC, CMOS is just a backing store */
-		lec &= TP_EC_BACKLIGHT_LVLMSK;
-		if (lec == lcmos)
-			tp_warned.bright_cmos_ec_unsync = 0;
-		else {
-			if (!tp_warned.bright_cmos_ec_unsync) {
-				printk(TPACPI_ERR
-					"CMOS NVRAM (%u) and EC (%u) do not "
-					"agree on display brightness level\n",
-					(unsigned int) lcmos,
-					(unsigned int) lec);
-				tp_warned.bright_cmos_ec_unsync = 1;
-			}
+	lnvram = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
+		  & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
+		  >> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
+	lnvram &= (tp_features.bright_16levels) ? 0x0f : 0x07;
+
+	return lnvram;
+}
+
+static void tpacpi_brightness_checkpoint_nvram(void)
+{
+	u8 lec = 0;
+	u8 b_nvram;
+
+	if (brightness_mode != TPACPI_BRGHT_MODE_ECNVRAM)
+		return;
+
+	vdbg_printk(TPACPI_DBG_BRGHT,
+		"trying to checkpoint backlight level to NVRAM...\n");
+
+	if (mutex_lock_killable(&brightness_mutex) < 0)
+		return;
+
+	if (unlikely(!acpi_ec_read(TP_EC_BACKLIGHT, &lec)))
+		goto unlock;
+	lec &= TP_EC_BACKLIGHT_LVLMSK;
+	b_nvram = nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
+
+	if (lec != ((b_nvram & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
+			     >> TP_NVRAM_POS_LEVEL_BRIGHTNESS)) {
+		/* NVRAM needs update */
+		b_nvram &= ~(TP_NVRAM_MASK_LEVEL_BRIGHTNESS <<
+				TP_NVRAM_POS_LEVEL_BRIGHTNESS);
+		b_nvram |= lec;
+		nvram_write_byte(b_nvram, TP_NVRAM_ADDR_BRIGHTNESS);
+		dbg_printk(TPACPI_DBG_BRGHT,
+			   "updated NVRAM backlight level to %u (0x%02x)\n",
+			   (unsigned int) lec, (unsigned int) b_nvram);
+	} else
+		vdbg_printk(TPACPI_DBG_BRGHT,
+			   "NVRAM backlight level already is %u (0x%02x)\n",
+			   (unsigned int) lec, (unsigned int) b_nvram);
+
+unlock:
+	mutex_unlock(&brightness_mutex);
+}
+
+
+/* call with brightness_mutex held! */
+static int tpacpi_brightness_get_raw(int *status)
+{
+	u8 lec = 0;
+
+	switch (brightness_mode) {
+	case TPACPI_BRGHT_MODE_UCMS_STEP:
+		*status = tpacpi_brightness_nvram_get();
+		return 0;
+	case TPACPI_BRGHT_MODE_EC:
+	case TPACPI_BRGHT_MODE_ECNVRAM:
+		if (unlikely(!acpi_ec_read(TP_EC_BACKLIGHT, &lec)))
 			return -EIO;
-		}
-	} else {
-		*status = level;
+		*status = lec;
+		return 0;
+	default:
+		return -ENXIO;
 	}
+}
+
+/* call with brightness_mutex held! */
+/* do NOT call with illegal backlight level value */
+static int tpacpi_brightness_set_ec(unsigned int value)
+{
+	u8 lec = 0;
+
+	if (unlikely(!acpi_ec_read(TP_EC_BACKLIGHT, &lec)))
+		return -EIO;
+
+	if (unlikely(!acpi_ec_write(TP_EC_BACKLIGHT,
+				(lec & TP_EC_BACKLIGHT_CMDMSK) |
+				(value & TP_EC_BACKLIGHT_LVLMSK))))
+		return -EIO;
+
+	return 0;
+}
+
+/* call with brightness_mutex held! */
+static int tpacpi_brightness_set_ucmsstep(unsigned int value)
+{
+	int cmos_cmd, inc;
+	unsigned int current_value, i;
+
+	current_value = tpacpi_brightness_nvram_get();
+
+	if (value == current_value)
+		return 0;
+
+	cmos_cmd = (value > current_value) ?
+			TP_CMOS_BRIGHTNESS_UP :
+			TP_CMOS_BRIGHTNESS_DOWN;
+	inc = (value > current_value) ? 1 : -1;
+
+	for (i = current_value; i != value; i += inc)
+		if (issue_thinkpad_cmos_command(cmos_cmd))
+			return -EIO;
 
 	return 0;
 }
 
 /* May return EINTR which can always be mapped to ERESTARTSYS */
-static int brightness_set(int value)
+static int brightness_set(unsigned int value)
 {
-	int cmos_cmd, inc, i, res;
-	int current_value;
-	int command_bits;
+	int res;
 
 	if (value > ((tp_features.bright_16levels)? 15 : 7) ||
 	    value < 0)
 		return -EINVAL;
 
+	vdbg_printk(TPACPI_DBG_BRGHT,
+			"set backlight level to %d\n", value);
+
 	res = mutex_lock_killable(&brightness_mutex);
 	if (res < 0)
 		return res;
 
-	res = brightness_get_raw(&current_value);
-	if (res < 0)
-		goto errout;
-
-	command_bits = current_value & TP_EC_BACKLIGHT_CMDMSK;
-	current_value &= TP_EC_BACKLIGHT_LVLMSK;
-
-	cmos_cmd = value > current_value ?
-			TP_CMOS_BRIGHTNESS_UP :
-			TP_CMOS_BRIGHTNESS_DOWN;
-	inc = (value > current_value)? 1 : -1;
-
-	res = 0;
-	for (i = current_value; i != value; i += inc) {
-		if ((brightness_mode & 2) &&
-		    issue_thinkpad_cmos_command(cmos_cmd)) {
-			res = -EIO;
-			goto errout;
-		}
-		if ((brightness_mode & 1) &&
-		    !acpi_ec_write(TP_EC_BACKLIGHT,
-				   (i + inc) | command_bits)) {
-			res = -EIO;
-			goto errout;;
-		}
+	switch (brightness_mode) {
+	case TPACPI_BRGHT_MODE_EC:
+	case TPACPI_BRGHT_MODE_ECNVRAM:
+		res = tpacpi_brightness_set_ec(value);
+		break;
+	case TPACPI_BRGHT_MODE_UCMS_STEP:
+		res = tpacpi_brightness_set_ucmsstep(value);
+		break;
+	default:
+		res = -ENXIO;
 	}
 
-errout:
 	mutex_unlock(&brightness_mutex);
 	return res;
 }
@@ -5645,21 +5715,34 @@ errout:
 
 static int brightness_update_status(struct backlight_device *bd)
 {
-	/* it is the backlight class's job (caller) to handle
-	 * EINTR and other errors properly */
-	return brightness_set(
+	unsigned int level =
 		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
 		 bd->props.power == FB_BLANK_UNBLANK) ?
-				bd->props.brightness : 0);
+				bd->props.brightness : 0;
+
+	dbg_printk(TPACPI_DBG_BRGHT,
+			"backlight: attempt to set level to %d\n",
+			level);
+
+	/* it is the backlight class's job (caller) to handle
+	 * EINTR and other errors properly */
+	return brightness_set(level);
 }
 
 static int brightness_get(struct backlight_device *bd)
 {
 	int status, res;
 
-	res = brightness_get_raw(&status);
+	res = mutex_lock_killable(&brightness_mutex);
 	if (res < 0)
-		return 0; /* FIXME: teach backlight about error handling */
+		return 0;
+
+	res = tpacpi_brightness_get_raw(&status);
+
+	mutex_unlock(&brightness_mutex);
+
+	if (res < 0)
+		return 0;
 
 	return status & TP_EC_BACKLIGHT_LVLMSK;
 }
@@ -5709,7 +5792,7 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	}
 
 	if (!brightness_enable) {
-		dbg_printk(TPACPI_DBG_INIT,
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_BRGHT,
 			   "brightness support disabled by "
 			   "module parameter\n");
 		return 1;
@@ -5724,20 +5807,38 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	if (b == 16)
 		tp_features.bright_16levels = 1;
 
-	if (!brightness_mode) {
-		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO)
-			brightness_mode = 2;
-		else
-			brightness_mode = 3;
+	/*
+	 * Check for module parameter bogosity, note that we
+	 * init brightness_mode to TPACPI_BRGHT_MODE_MAX in order to be
+	 * able to detect "unspecified"
+	 */
+	if (brightness_mode > TPACPI_BRGHT_MODE_MAX)
+		return -EINVAL;
 
-		dbg_printk(TPACPI_DBG_INIT, "selected brightness_mode=%d\n",
-			brightness_mode);
-	}
+	/* TPACPI_BRGHT_MODE_AUTO not implemented yet, just use default */
+	if (brightness_mode == TPACPI_BRGHT_MODE_AUTO ||
+	    brightness_mode == TPACPI_BRGHT_MODE_MAX) {
+		if (thinkpad_id.vendor == PCI_VENDOR_ID_IBM) {
+			/*
+			 * IBM models that define HBRV probably have
+			 * EC-based backlight level control
+			 */
+			if (acpi_evalf(ec_handle, NULL, "HBRV", "qd"))
+				/* T40-T43, R50-R52, R50e, R51e, X31-X41 */
+				brightness_mode = TPACPI_BRGHT_MODE_ECNVRAM;
+			else
+				/* all other IBM ThinkPads */
+				brightness_mode = TPACPI_BRGHT_MODE_UCMS_STEP;
+		} else
+			/* All Lenovo ThinkPads */
+			brightness_mode = TPACPI_BRGHT_MODE_UCMS_STEP;
 
-	if (brightness_mode > 3)
-		return -EINVAL;
+		dbg_printk(TPACPI_DBG_BRGHT,
+			   "selected brightness_mode=%d\n",
+			   brightness_mode);
+	}
 
-	if (brightness_get_raw(&b) < 0)
+	if (tpacpi_brightness_get_raw(&b) < 0)
 		return 1;
 
 	if (tp_features.bright_16levels)
@@ -5751,7 +5852,8 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		printk(TPACPI_ERR "Could not register backlight device\n");
 		return PTR_ERR(ibm_backlight_device);
 	}
-	vdbg_printk(TPACPI_DBG_INIT, "brightness is supported\n");
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_BRGHT,
+			"brightness is supported\n");
 
 	ibm_backlight_device->props.max_brightness =
 				(tp_features.bright_16levels)? 15 : 7;
@@ -5761,13 +5863,25 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	return 0;
 }
 
+static void brightness_suspend(pm_message_t state)
+{
+	tpacpi_brightness_checkpoint_nvram();
+}
+
+static void brightness_shutdown(void)
+{
+	tpacpi_brightness_checkpoint_nvram();
+}
+
 static void brightness_exit(void)
 {
 	if (ibm_backlight_device) {
-		vdbg_printk(TPACPI_DBG_EXIT,
+		vdbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_BRGHT,
 			    "calling backlight_device_unregister()\n");
 		backlight_device_unregister(ibm_backlight_device);
 	}
+
+	tpacpi_brightness_checkpoint_nvram();
 }
 
 static int brightness_read(char *p)
@@ -5814,6 +5928,9 @@ static int brightness_write(char *buf)
 			return -EINVAL;
 	}
 
+	tpacpi_disclose_usertask("procfs brightness",
+			"set level to %d\n", level);
+
 	/*
 	 * Now we know what the final level should be, so we try to set it.
 	 * Doing it this way makes the syscall restartable in case of EINTR
@@ -5827,6 +5944,8 @@ static struct ibm_struct brightness_driver_data = {
 	.read = brightness_read,
 	.write = brightness_write,
 	.exit = brightness_exit,
+	.suspend = brightness_suspend,
+	.shutdown = brightness_shutdown,
 };
 
 /*************************************************************************
@@ -7464,10 +7583,10 @@ module_param_named(fan_control, fan_control_allowed, bool, 0);
 MODULE_PARM_DESC(fan_control,
 		 "Enables setting fan parameters features when true");
 
-module_param_named(brightness_mode, brightness_mode, int, 0);
+module_param_named(brightness_mode, brightness_mode, uint, 0);
 MODULE_PARM_DESC(brightness_mode,
 		 "Selects brightness control strategy: "
-		 "0=auto, 1=EC, 2=CMOS, 3=both");
+		 "0=auto, 1=EC, 2=UCMS, 3=EC+NVRAM");
 
 module_param(brightness_enable, uint, 0);
 MODULE_PARM_DESC(brightness_enable,
-- 
1.6.2.1


------------------------------------------------------------------------------
