From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 11/13] ACPI: thinkpad-acpi: clean-up fan
	subdriver quirk
Date: Sun, 11 Jan 2009 03:01:08 -0200
Message-ID: <1231650070-21722-12-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Tino Keitel <tino.keitel-rAwCM5oiXHA@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Better document the Unitialized HFSP quirk, and modularize it a bit.
This makes the code flow easier to read and reduces LOC.

Apply the Unitialized HFSP closer to the source (i.e. inside the
get_fan_status()), this fixes a harmless buglet where at driver init
with the quirk active, the user could set the hwmon pwm1 attribute and
switch out of pwm1_mode=2 to pwm1_mode=0 without changing pwm1_mode
directly.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Tino Keitel <tino.keitel-rAwCM5oiXHA@public.gmane.org>
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
1.5.6.5


------------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It is the best place to buy or sell services for
just about anything Open Source.
http://p.sf.net/sfu/Xq1LFB
