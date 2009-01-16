From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/23] ACPI: thinkpad-acpi: clean-up fan subdriver quirk
Date: Fri, 16 Jan 2009 15:25:00 -0500
Message-ID: <1c2ece758a36b48133717e4db060fbe8fa52c5cd.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:60431 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759404AbZAPUZZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:25 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK009V2Z69GKM3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:20:34 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Tino Keitel <tino.keitel@tikei.de>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Better document the Unitialized HFSP quirk, and modularize it a bit.
This makes the code flow easier to read and reduces LOC.

Apply the Unitialized HFSP closer to the source (i.e. inside the
get_fan_status()), this fixes a harmless buglet where at driver init
with the quirk active, the user could set the hwmon pwm1 attribute and
switch out of pwm1_mode=2 to pwm1_mode=0 without changing pwm1_mode
directly.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Tino Keitel <tino.keitel@tikei.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |  109 ++++++++++++++++++----------------
 1 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d7d41ae..213219d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5897,6 +5897,60 @@ TPACPI_HANDLE(sfan, ec, "SFAN",	/* 570 */
 	   );			/* all others */
 
 /*
+ * Unitialized HFSP quirk: ACPI DSDT and EC fail to initialize the
+ * HFSP register at boot, so it contains 0x07 but the Thinkpad could
+ * be in auto mode (0x80).
+ *
+ * This is corrected by any write to HFSP either by the driver, or
+ * by the firmware.
+ *
+ * We assume 0x07 really means auto mode while this quirk is active,
+ * as this is far more likely than the ThinkPad being in level 7,
+ * which is only used by the firmware during thermal emergencies.
+ */
+
+static void fan_quirk1_detect(void)
+{
+	/* In some ThinkPads, neither the EC nor the ACPI
+	 * DSDT initialize the HFSP register, and it ends up
+	 * being initially set to 0x07 when it *could* be
+	 * either 0x07 or 0x80.
+	 *
+	 * Enable for TP-1Y (T43), TP-78 (R51e),
+	 * TP-76 (R52), TP-70 (T43, R52), which are known
+	 * to be buggy. */
+	if (fan_control_initial_status == 0x07) {
+		switch (thinkpad_id.ec_model) {
+		case 0x5931: /* TP-1Y */
+		case 0x3837: /* TP-78 */
+		case 0x3637: /* TP-76 */
+		case 0x3037: /* TP-70 */
+			printk(TPACPI_NOTICE
+			       "fan_init: initial fan status is unknown, "
+			       "assuming it is in auto mode\n");
+			tp_features.fan_ctrl_status_undef = 1;
+			;;
+		}
+	}
+}
+
+static void fan_quirk1_handle(u8 *fan_status)
+{
+	if (unlikely(tp_features.fan_ctrl_status_undef)) {
+		if (*fan_status != fan_control_initial_status) {
+			/* something changed the HFSP regisnter since
+			 * driver init time, so it is not undefined
+			 * anymore */
+			tp_features.fan_ctrl_status_undef = 0;
+		} else {
+			/* Return most likely status. In fact, it
+			 * might be the only possible status */
+			*fan_status = TP_EC_FAN_AUTO;
+		}
+	}
+}
+
+/*
  * Call with fan_mutex held
  */
 static void fan_update_desired_level(u8 status)
@@ -5934,8 +5988,10 @@ static int fan_get_status(u8 *status)
 		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
 			return -EIO;
 
-		if (likely(status))
+		if (likely(status)) {
 			*status = s;
+			fan_quirk1_handle(status);
+		}
 
 		break;
 
@@ -6245,16 +6301,6 @@ static ssize_t fan_pwm1_enable_show(struct device *dev,
 	if (res)
 		return res;
 
-	if (unlikely(tp_features.fan_ctrl_status_undef)) {
-		if (status != fan_control_initial_status) {
-			tp_features.fan_ctrl_status_undef = 0;
-		} else {
-			/* Return most likely status. In fact, it
-			 * might be the only possible status */
-			status = TP_EC_FAN_AUTO;
-		}
-	}
-
 	if (status & TP_EC_FAN_FULLSPEED) {
 		mode = 0;
 	} else if (status & TP_EC_FAN_AUTO) {
@@ -6319,14 +6365,6 @@ static ssize_t fan_pwm1_show(struct device *dev,
 	if (res)
 		return res;
 
-	if (unlikely(tp_features.fan_ctrl_status_undef)) {
-		if (status != fan_control_initial_status) {
-			tp_features.fan_ctrl_status_undef = 0;
-		} else {
-			status = TP_EC_FAN_AUTO;
-		}
-	}
-
 	if ((status &
 	     (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) != 0)
 		status = fan_control_desired_level;
@@ -6458,29 +6496,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		if (likely(acpi_ec_read(fan_status_offset,
 					&fan_control_initial_status))) {
 			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
-
-			/* In some ThinkPads, neither the EC nor the ACPI
-			 * DSDT initialize the fan status, and it ends up
-			 * being set to 0x07 when it *could* be either
-			 * 0x07 or 0x80.
-			 *
-			 * Enable for TP-1Y (T43), TP-78 (R51e),
-			 * TP-76 (R52), TP-70 (T43, R52), which are known
-			 * to be buggy. */
-			if (fan_control_initial_status == 0x07) {
-				switch (thinkpad_id.ec_model) {
-				case 0x5931: /* TP-1Y */
-				case 0x3837: /* TP-78 */
-				case 0x3637: /* TP-76 */
-				case 0x3037: /* TP-70 */
-					printk(TPACPI_NOTICE
-					       "fan_init: initial fan status "
-					       "is unknown, assuming it is "
-					       "in auto mode\n");
-					tp_features.fan_ctrl_status_undef = 1;
-					;;
-				}
-			}
+			fan_quirk1_detect();
 		} else {
 			printk(TPACPI_ERR
 			       "ThinkPad ACPI EC access misbehaving, "
@@ -6669,15 +6685,6 @@ static int fan_read(char *p)
 		if (rc < 0)
 			return rc;
 
-		if (unlikely(tp_features.fan_ctrl_status_undef)) {
-			if (status != fan_control_initial_status)
-				tp_features.fan_ctrl_status_undef = 0;
-			else
-				/* Return most likely status. In fact, it
-				 * might be the only possible status */
-				status = TP_EC_FAN_AUTO;
-		}
-
 		len += sprintf(p + len, "status:\t\t%s\n",
 			       (status != 0) ? "enabled" : "disabled");
 
-- 
1.5.6.6

