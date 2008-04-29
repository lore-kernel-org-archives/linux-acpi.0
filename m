From: Len Brown <lenb@kernel.org>
Subject: [PATCH 160/171] ACPI: thinkpad-acpi: fix brightness dimming control bug
Date: Tue, 29 Apr 2008 04:44:25 -0400
Message-ID: <d65c4d468e53011f24f61e5e6e8e8091815bb1aa.1209457072.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:45231 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760825AbYD2Ipf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:35 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

ibm-acpi and thinkpad-acpi did not know about bit 5 of the EC backlight
level control register (EC 0x31), so it was always forced to zero on
any writes.

This would disable the BIOS option to *not* use a dimmer backlight level
scale while on battery, and who knows what else (there are two other
control bits of unknown function).

Bit 5 controls the "reduce backlight levels when on battery" optional
functionality (active low).  Bits 6 and 7 are better left alone as well,
instead of being forced to zero.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   64 ++++++++++++++++++++++++++++++++----------
 1 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3513d99..1a26423 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4294,8 +4294,16 @@ static struct ibm_struct ecdump_driver_data = {
 
 #define TPACPI_BACKLIGHT_DEV_NAME "thinkpad_screen"
 
+enum {
+	TP_EC_BACKLIGHT = 0x31,
+
+	/* TP_EC_BACKLIGHT bitmasks */
+	TP_EC_BACKLIGHT_LVLMSK = 0x1F,
+	TP_EC_BACKLIGHT_CMDMSK = 0xE0,
+	TP_EC_BACKLIGHT_MAPSW = 0x20,
+};
+
 static struct backlight_device *ibm_backlight_device;
-static int brightness_offset = 0x31;
 static int brightness_mode;
 static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
 
@@ -4304,16 +4312,24 @@ static struct mutex brightness_mutex;
 /*
  * ThinkPads can read brightness from two places: EC 0x31, or
  * CMOS NVRAM byte 0x5E, bits 0-3.
+ *
+ * EC 0x31 has the following layout
+ *   Bit 7: unknown function
+ *   Bit 6: unknown function
+ *   Bit 5: Z: honour scale changes, NZ: ignore scale changes
+ *   Bit 4: must be set to zero to avoid problems
+ *   Bit 3-0: backlight brightness level
+ *
+ * brightness_get_raw returns status data in the EC 0x31 layout
  */
-static int brightness_get(struct backlight_device *bd)
+static int brightness_get_raw(int *status)
 {
 	u8 lec = 0, lcmos = 0, level = 0;
 
 	if (brightness_mode & 1) {
-		if (!acpi_ec_read(brightness_offset, &lec))
+		if (!acpi_ec_read(TP_EC_BACKLIGHT, &lec))
 			return -EIO;
-		lec &= (tp_features.bright_16levels)? 0x0f : 0x07;
-		level = lec;
+		level = lec & TP_EC_BACKLIGHT_LVLMSK;
 	};
 	if (brightness_mode & 2) {
 		lcmos = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
@@ -4324,6 +4340,8 @@ static int brightness_get(struct backlight_device *bd)
 	}
 
 	if (brightness_mode == 3) {
+		*status = lec;	/* Prefer EC, CMOS is just a backing store */
+		lec &= TP_EC_BACKLIGHT_LVLMSK;
 		if (lec == lcmos)
 			tp_warned.bright_cmos_ec_unsync = 0;
 		else {
@@ -4337,9 +4355,11 @@ static int brightness_get(struct backlight_device *bd)
 			}
 			return -EIO;
 		}
+	} else {
+		*status = level;
 	}
 
-	return level;
+	return 0;
 }
 
 /* May return EINTR which can always be mapped to ERESTARTSYS */
@@ -4347,19 +4367,22 @@ static int brightness_set(int value)
 {
 	int cmos_cmd, inc, i, res;
 	int current_value;
+	int command_bits;
 
-	if (value > ((tp_features.bright_16levels)? 15 : 7))
+	if (value > ((tp_features.bright_16levels)? 15 : 7) ||
+	    value < 0)
 		return -EINVAL;
 
 	res = mutex_lock_interruptible(&brightness_mutex);
 	if (res < 0)
 		return res;
 
-	current_value = brightness_get(NULL);
-	if (current_value < 0) {
-		res = current_value;
+	res = brightness_get_raw(&current_value);
+	if (res < 0)
 		goto errout;
-	}
+
+	command_bits = current_value & TP_EC_BACKLIGHT_CMDMSK;
+	current_value &= TP_EC_BACKLIGHT_LVLMSK;
 
 	cmos_cmd = value > current_value ?
 			TP_CMOS_BRIGHTNESS_UP :
@@ -4374,7 +4397,8 @@ static int brightness_set(int value)
 			goto errout;
 		}
 		if ((brightness_mode & 1) &&
-		    !acpi_ec_write(brightness_offset, i + inc)) {
+		    !acpi_ec_write(TP_EC_BACKLIGHT,
+				   (i + inc) | command_bits)) {
 			res = -EIO;
 			goto errout;;
 		}
@@ -4397,6 +4421,17 @@ static int brightness_update_status(struct backlight_device *bd)
 				bd->props.brightness : 0);
 }
 
+static int brightness_get(struct backlight_device *bd)
+{
+	int status, res;
+
+	res = brightness_get_raw(&status);
+	if (res < 0)
+		return 0; /* FIXME: teach backlight about error handling */
+
+	return status & TP_EC_BACKLIGHT_LVLMSK;
+}
+
 static struct backlight_ops ibm_backlight_data = {
 	.get_brightness = brightness_get,
 	.update_status  = brightness_update_status,
@@ -4461,8 +4496,7 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	if (brightness_mode > 3)
 		return -EINVAL;
 
-	b = brightness_get(NULL);
-	if (b < 0)
+	if (brightness_get_raw(&b) < 0)
 		return 1;
 
 	if (tp_features.bright_16levels)
@@ -4480,7 +4514,7 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 
 	ibm_backlight_device->props.max_brightness =
 				(tp_features.bright_16levels)? 15 : 7;
-	ibm_backlight_device->props.brightness = b;
+	ibm_backlight_device->props.brightness = b & TP_EC_BACKLIGHT_LVLMSK;
 	backlight_update_status(ibm_backlight_device);
 
 	return 0;
-- 
1.5.5.1.99.gf0ec4

