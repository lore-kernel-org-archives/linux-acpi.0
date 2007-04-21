From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 04/20] ACPI: thinkpad-acpi: rename thinkpad constants
Date: Sat, 21 Apr 2007 11:08:28 -0300
Message-ID: <1177164526845-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48787 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031164AbXDUOIz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Apr 2007 10:08:55 -0400
In-Reply-To: <11771645253042-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Rename all IBMACPI_ constants, now that we are not called ibm-acpi anymore.
Driver-specific constants are now prefixed TPACPI_, ThinkPad firmware
specific ones are now prefixed TP_CMOS_, TP_ACPI_, or TP_EC_.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |  188 +++++++++++++++++++++---------------------
 drivers/misc/thinkpad_acpi.h |   64 +++++++--------
 2 files changed, 125 insertions(+), 127 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 80ef195..1683bfe 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -781,16 +781,16 @@ static int video_init(void)
 
 	if (!vid_handle)
 		/* video switching not supported on R30, R31 */
-		video_supported = IBMACPI_VIDEO_NONE;
+		video_supported = TPACPI_VIDEO_NONE;
 	else if (acpi_evalf(vid_handle, &video_orig_autosw, "SWIT", "qd"))
 		/* 570 */
-		video_supported = IBMACPI_VIDEO_570;
+		video_supported = TPACPI_VIDEO_570;
 	else if (acpi_evalf(vid_handle, &video_orig_autosw, "^VADL", "qd"))
 		/* 600e/x, 770e, 770x */
-		video_supported = IBMACPI_VIDEO_770;
+		video_supported = TPACPI_VIDEO_770;
 	else
 		/* all others */
-		video_supported = IBMACPI_VIDEO_NEW;
+		video_supported = TPACPI_VIDEO_NEW;
 
 	return 0;
 }
@@ -805,15 +805,15 @@ static int video_status(void)
 	int status = 0;
 	int i;
 
-	if (video_supported == IBMACPI_VIDEO_570) {
+	if (video_supported == TPACPI_VIDEO_570) {
 		if (acpi_evalf(NULL, &i, "\\_SB.PHS", "dd", 0x87))
 			status = i & 3;
-	} else if (video_supported == IBMACPI_VIDEO_770) {
+	} else if (video_supported == TPACPI_VIDEO_770) {
 		if (acpi_evalf(NULL, &i, "\\VCDL", "d"))
 			status |= 0x01 * i;
 		if (acpi_evalf(NULL, &i, "\\VCDC", "d"))
 			status |= 0x02 * i;
-	} else if (video_supported == IBMACPI_VIDEO_NEW) {
+	} else if (video_supported == TPACPI_VIDEO_NEW) {
 		acpi_evalf(NULL, NULL, "\\VUPS", "vd", 1);
 		if (acpi_evalf(NULL, &i, "\\VCDC", "d"))
 			status |= 0x02 * i;
@@ -832,10 +832,10 @@ static int video_autosw(void)
 {
 	int autosw = 0;
 
-	if (video_supported == IBMACPI_VIDEO_570)
+	if (video_supported == TPACPI_VIDEO_570)
 		acpi_evalf(vid_handle, &autosw, "SWIT", "d");
-	else if (video_supported == IBMACPI_VIDEO_770 ||
-		 video_supported == IBMACPI_VIDEO_NEW)
+	else if (video_supported == TPACPI_VIDEO_770 ||
+		 video_supported == TPACPI_VIDEO_NEW)
 		acpi_evalf(vid_handle, &autosw, "^VDEE", "d");
 
 	return autosw & 1;
@@ -848,7 +848,7 @@ static int video_switch(void)
 
 	if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
 		return -EIO;
-	ret = video_supported == IBMACPI_VIDEO_570 ?
+	ret = video_supported == TPACPI_VIDEO_570 ?
 	    acpi_evalf(ec_handle, NULL, "_Q16", "v") :
 	    acpi_evalf(vid_handle, NULL, "VSWT", "v");
 	acpi_evalf(vid_handle, NULL, "_DOS", "vd", autosw);
@@ -858,9 +858,9 @@ static int video_switch(void)
 
 static int video_expand(void)
 {
-	if (video_supported == IBMACPI_VIDEO_570)
+	if (video_supported == TPACPI_VIDEO_570)
 		return acpi_evalf(ec_handle, NULL, "_Q17", "v");
-	else if (video_supported == IBMACPI_VIDEO_770)
+	else if (video_supported == TPACPI_VIDEO_770)
 		return acpi_evalf(vid_handle, NULL, "VEXP", "v");
 	else
 		return acpi_evalf(NULL, NULL, "\\VEXP", "v");
@@ -870,10 +870,10 @@ static int video_switch2(int status)
 {
 	int ret;
 
-	if (video_supported == IBMACPI_VIDEO_570) {
+	if (video_supported == TPACPI_VIDEO_570) {
 		ret = acpi_evalf(NULL, NULL,
 				 "\\_SB.PHS2", "vdd", 0x8b, status | 0x80);
-	} else if (video_supported == IBMACPI_VIDEO_770) {
+	} else if (video_supported == TPACPI_VIDEO_770) {
 		int autosw = video_autosw();
 		if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
 			return -EIO;
@@ -904,12 +904,12 @@ static int video_read(char *p)
 	len += sprintf(p + len, "status:\t\tsupported\n");
 	len += sprintf(p + len, "lcd:\t\t%s\n", enabled(status, 0));
 	len += sprintf(p + len, "crt:\t\t%s\n", enabled(status, 1));
-	if (video_supported == IBMACPI_VIDEO_NEW)
+	if (video_supported == TPACPI_VIDEO_NEW)
 		len += sprintf(p + len, "dvi:\t\t%s\n", enabled(status, 3));
 	len += sprintf(p + len, "auto:\t\t%s\n", enabled(autosw, 0));
 	len += sprintf(p + len, "commands:\tlcd_enable, lcd_disable\n");
 	len += sprintf(p + len, "commands:\tcrt_enable, crt_disable\n");
-	if (video_supported == IBMACPI_VIDEO_NEW)
+	if (video_supported == TPACPI_VIDEO_NEW)
 		len += sprintf(p + len, "commands:\tdvi_enable, dvi_disable\n");
 	len += sprintf(p + len, "commands:\tauto_enable, auto_disable\n");
 	len += sprintf(p + len, "commands:\tvideo_switch, expand_toggle\n");
@@ -936,10 +936,10 @@ static int video_write(char *buf)
 			enable |= 0x02;
 		} else if (strlencmp(cmd, "crt_disable") == 0) {
 			disable |= 0x02;
-		} else if (video_supported == IBMACPI_VIDEO_NEW &&
+		} else if (video_supported == TPACPI_VIDEO_NEW &&
 			   strlencmp(cmd, "dvi_enable") == 0) {
 			enable |= 0x08;
-		} else if (video_supported == IBMACPI_VIDEO_NEW &&
+		} else if (video_supported == TPACPI_VIDEO_NEW &&
 			   strlencmp(cmd, "dvi_disable") == 0) {
 			disable |= 0x08;
 		} else if (strlencmp(cmd, "auto_enable") == 0) {
@@ -1283,16 +1283,16 @@ static int led_init(void)
 {
 	if (!led_handle)
 		/* led not supported on R30, R31 */
-		led_supported = IBMACPI_LED_NONE;
+		led_supported = TPACPI_LED_NONE;
 	else if (strlencmp(led_path, "SLED") == 0)
 		/* 570 */
-		led_supported = IBMACPI_LED_570;
+		led_supported = TPACPI_LED_570;
 	else if (strlencmp(led_path, "SYSL") == 0)
 		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
-		led_supported = IBMACPI_LED_OLD;
+		led_supported = TPACPI_LED_OLD;
 	else
 		/* all others */
-		led_supported = IBMACPI_LED_NEW;
+		led_supported = TPACPI_LED_NEW;
 
 	return 0;
 }
@@ -1309,7 +1309,7 @@ static int led_read(char *p)
 	}
 	len += sprintf(p + len, "status:\t\tsupported\n");
 
-	if (led_supported == IBMACPI_LED_570) {
+	if (led_supported == TPACPI_LED_570) {
 		/* 570 */
 		int i, status;
 		for (i = 0; i < 8; i++) {
@@ -1354,23 +1354,23 @@ static int led_write(char *buf)
 		} else
 			return -EINVAL;
 
-		if (led_supported == IBMACPI_LED_570) {
+		if (led_supported == TPACPI_LED_570) {
 			/* 570 */
 			led = 1 << led;
 			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
 					led, led_sled_arg1[ind]))
 				return -EIO;
-		} else if (led_supported == IBMACPI_LED_OLD) {
+		} else if (led_supported == TPACPI_LED_OLD) {
 			/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
 			led = 1 << led;
-			ret = ec_write(IBMACPI_LED_EC_HLMS, led);
+			ret = ec_write(TPACPI_LED_EC_HLMS, led);
 			if (ret >= 0)
 				ret =
-				    ec_write(IBMACPI_LED_EC_HLBL,
+				    ec_write(TPACPI_LED_EC_HLBL,
 				    	     led * led_exp_hlbl[ind]);
 			if (ret >= 0)
 				ret =
-				    ec_write(IBMACPI_LED_EC_HLCL,
+				    ec_write(TPACPI_LED_EC_HLCL,
 				    	     led * led_exp_hlcl[ind]);
 			if (ret < 0)
 				return ret;
@@ -1467,29 +1467,29 @@ static int thermal_init(void)
 				printk(IBM_ERR
 				       "ThinkPad ACPI EC access misbehaving, "
 				       "falling back to ACPI TMPx access mode\n");
-				thermal_read_mode = IBMACPI_THERMAL_ACPI_TMP07;
+				thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
 			} else {
 				printk(IBM_ERR
 				       "ThinkPad ACPI EC access misbehaving, "
 				       "disabling thermal sensors access\n");
-				thermal_read_mode = IBMACPI_THERMAL_NONE;
+				thermal_read_mode = TPACPI_THERMAL_NONE;
 			}
 		} else {
 			thermal_read_mode =
 			    (ta2 != 0) ?
-			    IBMACPI_THERMAL_TPEC_16 : IBMACPI_THERMAL_TPEC_8;
+			    TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
 		}
 	} else if (acpi_tmp7) {
 		if (acpi_evalf(ec_handle, NULL, "UPDT", "qv")) {
 			/* 600e/x, 770e, 770x */
-			thermal_read_mode = IBMACPI_THERMAL_ACPI_UPDT;
+			thermal_read_mode = TPACPI_THERMAL_ACPI_UPDT;
 		} else {
 			/* Standard ACPI TMPx access, max 8 sensors */
-			thermal_read_mode = IBMACPI_THERMAL_ACPI_TMP07;
+			thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
 		}
 	} else {
 		/* temperatures not supported on 570, G4x, R30, R31, R32 */
-		thermal_read_mode = IBMACPI_THERMAL_NONE;
+		thermal_read_mode = TPACPI_THERMAL_NONE;
 	}
 
 	return 0;
@@ -1505,8 +1505,8 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 		return -EINVAL;
 
 	switch (thermal_read_mode) {
-#if IBMACPI_MAX_THERMAL_SENSORS >= 16
-	case IBMACPI_THERMAL_TPEC_16:
+#if TPACPI_MAX_THERMAL_SENSORS >= 16
+	case TPACPI_THERMAL_TPEC_16:
 		for (i = 0; i < 8; i++) {
 			if (!acpi_ec_read(0xC0 + i, &tmp))
 				return -EIO;
@@ -1514,15 +1514,15 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 		}
 		/* fallthrough */
 #endif
-	case IBMACPI_THERMAL_TPEC_8:
+	case TPACPI_THERMAL_TPEC_8:
 		for (i = 0; i < 8; i++) {
 			if (!acpi_ec_read(0x78 + i, &tmp))
 				return -EIO;
 			s->temp[i] = tmp * 1000;
 		}
-		return (thermal_read_mode == IBMACPI_THERMAL_TPEC_16) ? 16 : 8;
+		return (thermal_read_mode == TPACPI_THERMAL_TPEC_16) ? 16 : 8;
 
-	case IBMACPI_THERMAL_ACPI_UPDT:
+	case TPACPI_THERMAL_ACPI_UPDT:
 		if (!acpi_evalf(ec_handle, NULL, "UPDT", "v"))
 			return -EIO;
 		for (i = 0; i < 8; i++) {
@@ -1533,7 +1533,7 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 		}
 		return 8;
 
-	case IBMACPI_THERMAL_ACPI_TMP07:
+	case TPACPI_THERMAL_ACPI_TMP07:
 		for (i = 0; i < 8; i++) {
 			tmpi[3] = '0' + i;
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
@@ -1542,7 +1542,7 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 		}
 		return 8;
 
-	case IBMACPI_THERMAL_NONE:
+	case TPACPI_THERMAL_NONE:
 	default:
 		return 0;
 	}
@@ -1848,18 +1848,18 @@ static int volume_write(char *buf)
 /*
  * FAN ACCESS MODES
  *
- * IBMACPI_FAN_RD_ACPI_GFAN:
+ * TPACPI_FAN_RD_ACPI_GFAN:
  * 	ACPI GFAN method: returns fan level
  *
- * 	see IBMACPI_FAN_WR_ACPI_SFAN
+ * 	see TPACPI_FAN_WR_ACPI_SFAN
  * 	EC 0x2f not available if GFAN exists
  *
- * IBMACPI_FAN_WR_ACPI_SFAN:
+ * TPACPI_FAN_WR_ACPI_SFAN:
  * 	ACPI SFAN method: sets fan level, 0 (stop) to 7 (max)
  *
  * 	EC 0x2f might be available *for reading*, but never for writing.
  *
- * IBMACPI_FAN_WR_TPEC:
+ * TPACPI_FAN_WR_TPEC:
  * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode Supported
  * 	on almost all ThinkPads
  *
@@ -1888,7 +1888,7 @@ static int volume_write(char *buf)
  *			0x00 = stop
  * 			0x07 = max (set when temperatures critical)
  * 		Some ThinkPads may have other levels, see
- * 		IBMACPI_FAN_WR_ACPI_FANS (X31/X40/X41)
+ * 		TPACPI_FAN_WR_ACPI_FANS (X31/X40/X41)
  *
  *	FIRMWARE BUG: on some models, EC 0x2f might not be initialized at
  *	boot. Apparently the EC does not intialize it, so unless ACPI DSDT
@@ -1923,7 +1923,7 @@ static int volume_write(char *buf)
  *	For firmware bugs, refer to:
  *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
  *
- * IBMACPI_FAN_WR_ACPI_FANS:
+ * TPACPI_FAN_WR_ACPI_FANS:
  *	ThinkPad X31, X40, X41.  Not available in the X60.
  *
  *	FANS ACPI handle: takes three arguments: low speed, medium speed,
@@ -1940,7 +1940,7 @@ static int volume_write(char *buf)
  * 	ACPI DSDT switches which set is in use depending on various
  * 	factors.
  *
- * 	IBMACPI_FAN_WR_TPEC is also available and should be used to
+ * 	TPACPI_FAN_WR_TPEC is also available and should be used to
  * 	command the fan.  The X31/X40/X41 seems to have 8 fan levels,
  * 	but the ACPI tables just mention level 7.
  */
@@ -1966,21 +1966,21 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 
 static int fan_init(void)
 {
-	fan_status_access_mode = IBMACPI_FAN_NONE;
-	fan_control_access_mode = IBMACPI_FAN_WR_NONE;
+	fan_status_access_mode = TPACPI_FAN_NONE;
+	fan_control_access_mode = TPACPI_FAN_WR_NONE;
 	fan_control_commands = 0;
 	fan_control_status_known = 1;
 	fan_watchdog_maxinterval = 0;
 
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
-		fan_status_access_mode = IBMACPI_FAN_RD_ACPI_GFAN;
+		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
 	} else {
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
 		if (likely(acpi_ec_read(fan_status_offset,
 					&fan_control_initial_status))) {
-			fan_status_access_mode = IBMACPI_FAN_RD_TPEC;
+			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
 
 			/* In some ThinkPads, neither the EC nor the ACPI
 			 * DSDT initialize the fan status, and it ends up
@@ -2015,9 +2015,9 @@ static int fan_init(void)
 
 	if (sfan_handle) {
 		/* 570, 770x-JL */
-		fan_control_access_mode = IBMACPI_FAN_WR_ACPI_SFAN;
+		fan_control_access_mode = TPACPI_FAN_WR_ACPI_SFAN;
 		fan_control_commands |=
-		    IBMACPI_FAN_CMD_LEVEL | IBMACPI_FAN_CMD_ENABLE;
+		    TPACPI_FAN_CMD_LEVEL | TPACPI_FAN_CMD_ENABLE;
 	} else {
 		if (!gfan_handle) {
 			/* gfan without sfan means no fan control */
@@ -2026,16 +2026,16 @@ static int fan_init(void)
 			if (fans_handle) {
 				/* X31, X40, X41 */
 				fan_control_access_mode =
-				    IBMACPI_FAN_WR_ACPI_FANS;
+				    TPACPI_FAN_WR_ACPI_FANS;
 				fan_control_commands |=
-				    IBMACPI_FAN_CMD_SPEED |
-				    IBMACPI_FAN_CMD_LEVEL |
-				    IBMACPI_FAN_CMD_ENABLE;
+				    TPACPI_FAN_CMD_SPEED |
+				    TPACPI_FAN_CMD_LEVEL |
+				    TPACPI_FAN_CMD_ENABLE;
 			} else {
-				fan_control_access_mode = IBMACPI_FAN_WR_TPEC;
+				fan_control_access_mode = TPACPI_FAN_WR_TPEC;
 				fan_control_commands |=
-				    IBMACPI_FAN_CMD_LEVEL |
-				    IBMACPI_FAN_CMD_ENABLE;
+				    TPACPI_FAN_CMD_LEVEL |
+				    TPACPI_FAN_CMD_ENABLE;
 			}
 		}
 	}
@@ -2048,10 +2048,10 @@ static int fan_get_status(u8 *status)
 	u8 s;
 
 	/* TODO:
-	 * Add IBMACPI_FAN_RD_ACPI_FANS ? */
+	 * Add TPACPI_FAN_RD_ACPI_FANS ? */
 
 	switch (fan_status_access_mode) {
-	case IBMACPI_FAN_RD_ACPI_GFAN:
+	case TPACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
 
 		if (unlikely(!acpi_evalf(gfan_handle, &s, NULL, "d")))
@@ -2062,7 +2062,7 @@ static int fan_get_status(u8 *status)
 
 		break;
 
-	case IBMACPI_FAN_RD_TPEC:
+	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
 			return -EIO;
@@ -2090,7 +2090,7 @@ static int fan_get_speed(unsigned int *speed)
 	u8 hi, lo;
 
 	switch (fan_status_access_mode) {
-	case IBMACPI_FAN_RD_TPEC:
+	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		if (unlikely(!acpi_ec_read(fan_rpm_offset, &lo) ||
 			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
@@ -2140,7 +2140,7 @@ static void fan_watchdog_reset(void)
 static int fan_set_level(int level)
 {
 	switch (fan_control_access_mode) {
-	case IBMACPI_FAN_WR_ACPI_SFAN:
+	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (level >= 0 && level <= 7) {
 			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
 				return -EIO;
@@ -2148,10 +2148,10 @@ static int fan_set_level(int level)
 			return -EINVAL;
 		break;
 
-	case IBMACPI_FAN_WR_ACPI_FANS:
-	case IBMACPI_FAN_WR_TPEC:
-		if ((level != IBMACPI_FAN_EC_AUTO) &&
-		    (level != IBMACPI_FAN_EC_DISENGAGED) &&
+	case TPACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_TPEC:
+		if ((level != TP_EC_FAN_AUTO) &&
+		    (level != TP_EC_FAN_FULLSPEED) &&
 		    ((level < 0) || (level > 7)))
 			return -EINVAL;
 
@@ -2173,14 +2173,14 @@ static int fan_set_enable(void)
 	int rc;
 
 	switch (fan_control_access_mode) {
-	case IBMACPI_FAN_WR_ACPI_FANS:
-	case IBMACPI_FAN_WR_TPEC:
+	case TPACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_TPEC:
 		if ((rc = fan_get_status(&s)) < 0)
 			return rc;
 
 		/* Don't go out of emergency fan mode */
 		if (s != 7)
-			s = IBMACPI_FAN_EC_AUTO;
+			s = TP_EC_FAN_AUTO;
 
 		if (!acpi_ec_write(fan_status_offset, s))
 			return -EIO;
@@ -2188,7 +2188,7 @@ static int fan_set_enable(void)
 			fan_control_status_known = 1;
 		break;
 
-	case IBMACPI_FAN_WR_ACPI_SFAN:
+	case TPACPI_FAN_WR_ACPI_SFAN:
 		if ((rc = fan_get_status(&s)) < 0)
 			return rc;
 
@@ -2211,15 +2211,15 @@ static int fan_set_enable(void)
 static int fan_set_disable(void)
 {
 	switch (fan_control_access_mode) {
-	case IBMACPI_FAN_WR_ACPI_FANS:
-	case IBMACPI_FAN_WR_TPEC:
+	case TPACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_TPEC:
 		if (!acpi_ec_write(fan_status_offset, 0x00))
 			return -EIO;
 		else
 			fan_control_status_known = 1;
 		break;
 
-	case IBMACPI_FAN_WR_ACPI_SFAN:
+	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", 0x00))
 			return -EIO;
 		break;
@@ -2233,7 +2233,7 @@ static int fan_set_disable(void)
 static int fan_set_speed(int speed)
 {
 	switch (fan_control_access_mode) {
-	case IBMACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_ACPI_FANS:
 		if (speed >= 0 && speed <= 65535) {
 			if (!acpi_evalf(fans_handle, NULL, NULL, "vddd",
 					speed, speed, speed))
@@ -2256,7 +2256,7 @@ static int fan_read(char *p)
 	unsigned int speed = 0;
 
 	switch (fan_status_access_mode) {
-	case IBMACPI_FAN_RD_ACPI_GFAN:
+	case TPACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
 		if ((rc = fan_get_status(&status)) < 0)
 			return rc;
@@ -2266,7 +2266,7 @@ static int fan_read(char *p)
 			       (status != 0) ? "enabled" : "disabled", status);
 		break;
 
-	case IBMACPI_FAN_RD_TPEC:
+	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		if ((rc = fan_get_status(&status)) < 0)
 			return rc;
@@ -2277,7 +2277,7 @@ static int fan_read(char *p)
 			else
 				/* Return most likely status. In fact, it
 				 * might be the only possible status */
-				status = IBMACPI_FAN_EC_AUTO;
+				status = TP_EC_FAN_AUTO;
 		}
 
 		len += sprintf(p + len, "status:\t\t%s\n",
@@ -2291,25 +2291,25 @@ static int fan_read(char *p)
 
 		len += sprintf(p + len, "speed:\t\t%d\n", speed);
 
-		if (status & IBMACPI_FAN_EC_DISENGAGED)
+		if (status & TP_EC_FAN_FULLSPEED)
 			/* Disengaged mode takes precedence */
 			len += sprintf(p + len, "level:\t\tdisengaged\n");
-		else if (status & IBMACPI_FAN_EC_AUTO)
+		else if (status & TP_EC_FAN_AUTO)
 			len += sprintf(p + len, "level:\t\tauto\n");
 		else
 			len += sprintf(p + len, "level:\t\t%d\n", status);
 		break;
 
-	case IBMACPI_FAN_NONE:
+	case TPACPI_FAN_NONE:
 	default:
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	}
 
-	if (fan_control_commands & IBMACPI_FAN_CMD_LEVEL) {
+	if (fan_control_commands & TPACPI_FAN_CMD_LEVEL) {
 		len += sprintf(p + len, "commands:\tlevel <level>");
 
 		switch (fan_control_access_mode) {
-		case IBMACPI_FAN_WR_ACPI_SFAN:
+		case TPACPI_FAN_WR_ACPI_SFAN:
 			len += sprintf(p + len, " (<level> is 0-7)\n");
 			break;
 
@@ -2320,12 +2320,12 @@ static int fan_read(char *p)
 		}
 	}
 
-	if (fan_control_commands & IBMACPI_FAN_CMD_ENABLE)
+	if (fan_control_commands & TPACPI_FAN_CMD_ENABLE)
 		len += sprintf(p + len, "commands:\tenable, disable\n"
 			       "commands:\twatchdog <timeout> (<timeout> is 0 (off), "
 			       "1-120 (seconds))\n");
 
-	if (fan_control_commands & IBMACPI_FAN_CMD_SPEED)
+	if (fan_control_commands & TPACPI_FAN_CMD_SPEED)
 		len += sprintf(p + len, "commands:\tspeed <speed>"
 			       " (<speed> is 0-65535)\n");
 
@@ -2337,9 +2337,9 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
 	int level;
 
 	if (strlencmp(cmd, "level auto") == 0)
-		level = IBMACPI_FAN_EC_AUTO;
+		level = TP_EC_FAN_AUTO;
 	else if (strlencmp(cmd, "level disengaged") == 0)
-		level = IBMACPI_FAN_EC_DISENGAGED;
+		level = TP_EC_FAN_FULLSPEED;
 	else if (sscanf(cmd, "level %d", &level) != 1)
 		return 0;
 
@@ -2412,13 +2412,13 @@ static int fan_write(char *buf)
 	int rc = 0;
 
 	while (!rc && (cmd = next_cmd(&buf))) {
-		if (!((fan_control_commands & IBMACPI_FAN_CMD_LEVEL) &&
+		if (!((fan_control_commands & TPACPI_FAN_CMD_LEVEL) &&
 		      fan_write_cmd_level(cmd, &rc)) &&
-		    !((fan_control_commands & IBMACPI_FAN_CMD_ENABLE) &&
+		    !((fan_control_commands & TPACPI_FAN_CMD_ENABLE) &&
 		      (fan_write_cmd_enable(cmd, &rc) ||
 		       fan_write_cmd_disable(cmd, &rc) ||
 		       fan_write_cmd_watchdog(cmd, &rc))) &&
-		    !((fan_control_commands & IBMACPI_FAN_CMD_SPEED) &&
+		    !((fan_control_commands & TPACPI_FAN_CMD_SPEED) &&
 		      fan_write_cmd_speed(cmd, &rc))
 		    )
 			rc = -EINVAL;
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 8b2fd1a..02a297e 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -256,29 +256,27 @@ enum {					/* Fan control constants */
 	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
 					 * 0x84 must be read before 0x85 */
 
-	IBMACPI_FAN_EC_DISENGAGED 	= 0x40,	/* EC mode: tachometer
-						 * disengaged */
-	IBMACPI_FAN_EC_AUTO		= 0x80, /* EC mode: auto fan
-						 * control */
+	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
+	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
 };
 
 enum fan_status_access_mode {
-	IBMACPI_FAN_NONE = 0,		/* No fan status or control */
-	IBMACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
-	IBMACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
+	TPACPI_FAN_NONE = 0,		/* No fan status or control */
+	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
+	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
 };
 
 enum fan_control_access_mode {
-	IBMACPI_FAN_WR_NONE = 0,	/* No fan control */
-	IBMACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
-	IBMACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
-	IBMACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
+	TPACPI_FAN_WR_NONE = 0,		/* No fan control */
+	TPACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
+	TPACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
+	TPACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
 };
 
 enum fan_control_commands {
-	IBMACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
-	IBMACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
-	IBMACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd,
+	TPACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
+	TPACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
+	TPACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd,
 						 * and also watchdog cmd */
 };
 
@@ -333,16 +331,16 @@ static int hotkey_write(char *buf);
  */
 
 enum led_access_mode {
-	IBMACPI_LED_NONE = 0,
-	IBMACPI_LED_570,	/* 570 */
-	IBMACPI_LED_OLD,	/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
-	IBMACPI_LED_NEW,	/* all others */
+	TPACPI_LED_NONE = 0,
+	TPACPI_LED_570,	/* 570 */
+	TPACPI_LED_OLD,	/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
+	TPACPI_LED_NEW,	/* all others */
 };
 
-enum {	/* For IBMACPI_LED_OLD */
-	IBMACPI_LED_EC_HLCL = 0x0c,	/* EC reg to get led to power on */
-	IBMACPI_LED_EC_HLBL = 0x0d,	/* EC reg to blink a lit led */
-	IBMACPI_LED_EC_HLMS = 0x0e,	/* EC reg to select led to command */
+enum {	/* For TPACPI_LED_OLD */
+	TPACPI_LED_EC_HLCL = 0x0c,	/* EC reg to get led to power on */
+	TPACPI_LED_EC_HLBL = 0x0d,	/* EC reg to blink a lit led */
+	TPACPI_LED_EC_HLMS = 0x0e,	/* EC reg to select led to command */
 };
 
 static enum led_access_mode led_supported;
@@ -370,16 +368,16 @@ static int light_write(char *buf);
  */
 
 enum thermal_access_mode {
-	IBMACPI_THERMAL_NONE = 0,	/* No thermal support */
-	IBMACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
-	IBMACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
-	IBMACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
-	IBMACPI_THERMAL_TPEC_16,	/* Use ACPI EC regs, 16 sensors */
+	TPACPI_THERMAL_NONE = 0,	/* No thermal support */
+	TPACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
+	TPACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
+	TPACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
+	TPACPI_THERMAL_TPEC_16,		/* Use ACPI EC regs, 16 sensors */
 };
 
-#define IBMACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
+#define TPACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
 struct ibm_thermal_sensors_struct {
-	s32 temp[IBMACPI_MAX_THERMAL_SENSORS];
+	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
 };
 
 static int thermal_init(void);
@@ -392,10 +390,10 @@ static int thermal_read(char *p);
  */
 
 enum video_access_mode {
-	IBMACPI_VIDEO_NONE = 0,
-	IBMACPI_VIDEO_570,	/* 570 */
-	IBMACPI_VIDEO_770,	/* 600e/x, 770e, 770x */
-	IBMACPI_VIDEO_NEW,	/* all others */
+	TPACPI_VIDEO_NONE = 0,
+	TPACPI_VIDEO_570,	/* 570 */
+	TPACPI_VIDEO_770,	/* 600e/x, 770e, 770x */
+	TPACPI_VIDEO_NEW,	/* all others */
 };
 
 static enum video_access_mode video_supported;
-- 
1.5.1

